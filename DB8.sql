CREATE TABLE "public"."Flights" (
    "FlightId" int,
    "FlightTime" timestamp,
    "PlaneId" int NOT NULL,
    "ClosedByManager" boolean default false,
    PRIMARY KEY ("FlightId")
);

CREATE TABLE "public"."Seats" (
    "PlaneId" int,
    "SeatNo" int,
    PRIMARY KEY ("PlaneId", "SeatNo")
);

CREATE TABLE "public"."Ticket" (
    "FlightId" int,
    "SeatNo" int,
    CONSTRAINT "Flight_Id_FK" FOREIGN KEY ("FlightId") REFERENCES "public"."Flights"("FlightId"),
    PRIMARY KEY ("FlightId", "SeatNo")
);


ALTER TABLE "public"."Ticket"
  ADD COLUMN "BookDate" timestamp,
  ADD COLUMN "BuyDate" timestamp,
  ADD COLUMN "UserPassportNo" varchar(15);
  ADD COLUMN "Buy" boolean;

ALTER TABLE "public"."Ticket"
  ALTER COLUMN "BookDate" SET DATA TYPE timestamp,
  ALTER COLUMN "BuyDate" SET DATA TYPE timestamp;

create or replace function onTicketUpdate() returns trigger as $$begin
    if (select "ClosedByManager" from "Flights" where "FlightId" = old."FlightId") then
        return null;
    end if;
    if (old."BuyDate" is not null) then
        return null;
    end if;
    if (not new."Buy" and (extract (epoch from (select "FlightTime" from "Flights" where "FlightId" = old."FlightId") - now()) / 3600 < 24)) then
        return null;
    end if;
    if (extract (epoch from (select "FlightTime" from "Flights" where "FlightId" = old."FlightId") - now()) / 3600 < 2) then
        return null;
    end if;
    if (old."BookDate" is not null and (extract (epoch from old."BookDate" - now()) / 3600 < 24)) then
        if (old."UserPassportNo" = new."UserPassportNo") then
            if (new."Buy") then
                new."BookDate" := null;
                new."BuyDate" := now();
                return new;
            end if;
            new."BookDate" = now();
            return new;
        end if;
        return null;
    end if;
    if (new."Buy") then
        new."BookDate" := null;
        new."BuyDate" := now();
        return new;
    end if;
    new."BookDate" = now();
    return new;
end$$ language plpgsql; 

create trigger onTicketUpdateTrigger 
    before update on "Ticket" for each row execute procedure onTicketUpdate();

create or replace function onTicketInsert() returns trigger as $$begin
    if (extract (epoch from (select "FlightTime" from "Flights" where "FlightId" = new."FlightId") - now()) / 3600 < 2) then
        return null;
    end if;
    if (select "ClosedByManager" from "Flights" where "FlightId" = new."FlightId") then
        return null;
    end if;
    if (new."Buy") then
        new."BuyDate" := now();
        return new;
    end if;
    if (extract (epoch from (select "FlightTime" from "Flights" where "FlightId" = new."FlightId") - now()) / 3600 < 24) then
        return null;
    end if;
    new."BookDate" := now();
    return new;
end$$ language plpgsql;

create trigger onTicketInsertTrigger 
    before insert on "Ticket" for each row execute procedure onTicketInsert();

create index FieldId_To_ClosedByManager on "Flights" ("FlightId", "ClosedByManager");

create index FieldId_And_SeatNo_To_UserPassportNo_Index on "Ticket" ("FlightId", "SeatNo", "UserPassportNo", "Buy");