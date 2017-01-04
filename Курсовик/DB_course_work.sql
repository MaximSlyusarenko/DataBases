create database FIFA;

CREATE TABLE Commitee (
    cid int,
    startYear int NOT NULL,
    finishYear int NOT NULL,
    PRIMARY KEY (id)
);


CREATE TABLE Country (
    countryId int,
    name varchar(100) NOT NULL,
    regFedId int,
    CONSTRAINT FK_Country_Regional_Federation FOREIGN KEY (regFedId) REFERENCES Regional_Federation(regFedId),
    PRIMARY KEY (countryId)
);

CREATE TABLE Candidate (
    candId int,
    firstName varchar(100) NOT NULL,
    lastName varchar(100) NOT NULL,
    countryId int,
    PRIMARY KEY (candId),
    CONSTRAINT FK_Candidate_Country FOREIGN KEY (countryId) REFERENCES Country(countryId)
);

CREATE TABLE Commiteeman (
    cid int,
    candId int,
    electionDate date NOT NULL,
    CONSTRAINT FK_Commiteeman_Commitee FOREIGN KEY (cid) REFERENCES Commitee(cid),
    CONSTRAINT FK_Commiteeman_Candidate FOREIGN KEY (candId) REFERENCES Candidate(candId),
    PRIMARY KEY (cid, candId)
);

CREATE TABLE World_Cup (
    year int,
    PRIMARY KEY (year)
);

CREATE TABLE World_Cup_Result (
    countryId int,
    year int,
    result varchar(50) NOT NULL,
    CONSTRAINT FK_World_Cup_Result_Country FOREIGN KEY (countryId) REFERENCES Country(countryId),
    CONSTRAINT FK_World_Cup_Result_World_Cup FOREIGN KEY (year) REFERENCES World_Cup(year),
    PRIMARY KEY (countryId, year)
);

CREATE TABLE National_Championship (
    natChampId int,
    name varchar(100) NOT NULL,
    rang int NOT NULL,
    countryId int,
    PRIMARY KEY (natChampId),
    CONSTRAINT FK_National_Championship_Country FOREIGN KEY (countryId) REFERENCES Country(countryId)
);

CREATE TABLE Club (
    clubId int,
    name varchar(100) NOT NULL,
    countryId,
    CONSTRAINT FK_Club_Country FOREIGN KEY (countryId) REFERENCES Country(countryId),
    PRIMARY KEY (clubId)
);

CREATE TABLE National_Championship_Result (
    natChampId int NOT NULL,
    clubId int,
    season int NOT NULL,
    place int NOT NULL,
    CONSTRAINT FK_National_Championship_Result_National_Championship FOREIGN KEY (natChampId) REFERENCES National_Championship(natChampId),
    CONSTRAINT FK_National_Championship_Result_Club FOREIGN KEY (clubId) REFERENCES Club(clubId),
    PRIMARY KEY (clubId, season)
);

CREATE TABLE Regional_Federation (
    regFedId int,
    regionName varchar(100) NOT NULL,
    name varchar(100) NOT NULL,
    PRIMARY KEY (regFedId)
);

CREATE TABLE Regional_International_Tournament (
    regTournId int,
    name varchar(100) NOT NULL,
    regFedId int,
    PRIMARY KEY (regTournId),
    CONSTRAINT FK_Regional_International_Tournament_Regional_Federation FOREIGN KEY (regFedId) REFERENCES Regional_Federation(regFedId)
);

CREATE TABLE Regional_Tournament_Result (
    countryId int,
    regTournId int NOT NULL,
    year int NOT NULL,
    result varchar(50) NOT NULL,
    CONSTRAINT FK_Regional_Tournament_Result_Country FOREIGN KEY (countryId) REFERENCES Country(countryId),
    CONSTRAINT FK_Regional_Tournament_Result_Regional_International_Tournament FOREIGN KEY (regTournId) REFERENCES Regional_International_Tournament(regTournId),
    PRIMARY KEY (countryId, year)
);

CREATE TABLE Regional_Club_Tournament (
    regClubTournId int,
    name varchar(100) NOT NULL,
    regFedId int,
    PRIMARY KEY (regClubTournId),
    CONSTRAINT FK_Regional_Club_Tournament_Regional_Federation FOREIGN KEY (regFedId) REFERENCES Regional_Federation(regFedId)
);

CREATE TABLE Regional_Club_Tournament_Result (
    regClubTournId int NOT NULL,
    clubId int,
    season int NOT NULL,
    result varchar(50) NOT NULL,
    CONSTRAINT FK_Regional_Club_Tournament_Result_Regional_Club_Tournament FOREIGN KEY (regClubTournId) REFERENCES Regional_Club_Tournament(regClubTournId),
    CONSTRAINT FK_Regional_Club_Tournament_Result_Club FOREIGN KEY (clubId) REFERENCES Club(clubId),
    PRIMARY KEY (clubId, season)
);

CREATE TABLE Player (
    playerId int,
    firstName varchar(100) NOT NULL,
    lastName varchar(100) NOT NULL,
    clubId int,
    PRIMARY KEY (playerId),
    CONSTRAINT FK_Player_Club FOREIGN KEY (clubId) REFERENCES Club(clubId)
);

CREATE TABLE Transfer (
    transferId int,
    playerId int,
    fromClubId int,
    toClubId int,
    price int NOT NULL,
    PRIMARY KEY (transferId),
    CONSTRAINT FK_Transfer_Player FOREIGN KEY (playerId) REFERENCES Player(playerId),
    CONSTRAINT FK_Transfer_Club_From FOREIGN KEY (fromClubId) REFERENCES Club(clubId),
    CONSTRAINT FK_Transfer_Club_To FOREIGN KEY (toClubId) REFERENCES Club(clubId)
);

CREATE TABLE Golden_Ball (
    year int,
    playerId int,
    PRIMARY KEY (year),
    CONSTRAINT FK_Golden_Ball_Player FOREIGN KEY (playerId) REFERENCES Player(playerId)
);

INSERT INTO Commitee(cid, startYear, finishYear) VALUES(3, 2013, 2017), (2, 2009, 2013), (1, 2005, 2009);

INSERT INTO Country(countryId, name, regFedId) VALUES(1, 'Russia', 1), (2, 'Italy', 1), (3, 'Switzerland', 1), (4, 'USA', 4), 
(5, 'Brazil', 3), (6, 'Argentina', 3), (7, 'China', 2), (8, 'New Zealand', 6), (9, 'Australia', 2), (10, 'Germany', 1), 
(11, 'England', 1), (12, 'France', 1), (13, 'Spain', 1), (14, 'Chile', 3);

INSERT INTO Candidate(candId, firstName, lastName, countryId) VALUES(1, 'Zepp', 'Blatter', 3), 
(2, 'Gianni', 'Infantino', 2), (3, 'Vitaliy', 'Mutko', 1), (4, 'Michele', 'Platiny', 12);

INSERT INTO Commiteeman(cid, candId, electionDate) VALUES(1, 1, '01-01-2005'), (1, 4, '01-01-2005'), 
(2, 1, '01-01-2009'), (2, 2, '01-01-2009'), (2, 3, '01-01-2009'), (2, 4, '01-01-2009'), 
(3, 2, '01-01-2013'), (3, 3, '01-01-2013');

INSERT INTO World_Cup(year) VALUES(2006), (2010), (2014);

INSERT INTO World_Cup_Result(countryId, year, result) VALUES(2, 2006, 'winner'), (3, 2006, '1/8'), (4, 2006, 'group')
, (5, 2006, '1/4'), (6, 2006, '1/4'), (9, 2006, '1/8'), (10, 2006, '3 place'), (11, 2006, '1/4')
, (12, 2006, 'final'), (13, 2006, '1/8'), (2, 2010, 'group'), (3, 2010, 'group'), (4, 2010, '1/8')
, (5, 2010, '1/4'), (6, 2010, '1/4'), (8, 2010, 'group'), (9, 2010, 'group'), (10, 2010, '3 place')
, (11, 2010, '1/8'), (12, 2010, 'group'), (13, 2010, 'winner'), (14, 2010, '1/8'), (1, 2014, 'group'), (2, 2014, 'group')
, (3, 2014, '1/8'), (4, 2014, '1/8'), (5, 2014, '4 place'), (6, 2014, 'final'), (9, 2014, 'group')
, (10, 2014, 'winner'), (11, 2014, 'group'), (12, 2014, '1/4'), (13, 2014, 'group'), (14, 2014, '1/8');

INSERT INTO National_Championship(natChampId, name, rang, countryId) VALUES(1, 'Barclays Premier League', 1, 11)
, (2, 'Russian Premier League', 1, 1) , (3, 'Liga BBVA', 1, 13) , (4, 'Bundesliga', 1, 10) , (5, 'Liga 1', 1, 12);

INSERT INTO Club(clubId, name, countryId) VALUES(1, 'Chelsea', 11), (2, 'Liecester', 11), (3, 'CSKA', 1), (4, 'Zenit', 1)
, (5, 'Barcelona', 13), (6, 'Real Madrid C.F.', 13), (7, 'Bayern Munich', 10), (8, 'PSG', 12);

INSERT INTO National_Championship_Result(natChampId, clubId, season, place) VALUES(1, 1, 2014, 1), 
(1, 2, 2014, 14), (1, 1, 2015, 10), (1, 2, 2015, 1), (2, 3, 2014, 2), (2, 4, 2014, 1), (2, 3, 2015, 1), 
(2, 4, 2015, 3), (3, 5, 2014, 1), (3, 6, 2014, 2), (3, 5, 2015, 1), (3, 6, 2015, 2), (4, 7, 2014, 1),
(4, 7, 2015, 1), (5, 8, 2014, 1), (5, 8, 2015, 1);

INSERT INTO Regional_Federation(regFedId, regionName, name) VALUES(1, 'Europe', 'UEFA'), (2, 'Asia', 'AFC'), 
(3, 'South America', 'CONMEBOL'), (4, 'North America', 'CONCACAF'), (5, 'Africa', 'CAF'), (6, 'Australia', 'OFC');

INSERT INTO Regional_International_Tournament(regTournId, name, regFedId) VALUES(1, 'European Championship', 1),
(2, 'Asia Cup', 2), (3, 'Copa America', 3), (4, 'Concacaf cup', 4), 
(5, 'Cup of African Nations', 5), (6, 'Australia and Oceania Cup', 6);

INSERT INTO Regional_Tournament_Result(countryId, regTournId, year, result) VALUES(1, 1, 2012, 'group'),
(2, 1, 2012, '2 place'), (10, 1, 2012, '3 place'), (11, 1, 2012, '1/4'), (12, 1, 2012, '1/4'),
(13, 1, 2012, 'winner'), (1, 1, 2016, 'group'), (2, 1, 2016, '1/4'), (3, 1, 2016, '1/8'),
(10, 1, 2016, '3 place'), (11, 1, 2016, '1/8'), (12, 1, 2016, '2 place'), (13, 1, 2016, '1/8'),
(7, 2, 2011, 'group'), (9, 2, 2011, '2 place'), (7, 2, 2015, '1/4'), (9, 2, 2015, 'winner'),
(5, 3, 2015, '1/4'), (6, 3, 2015, '2 place'), (14, 3, 2015, 'winner'), (5, 3, 2016, 'group'),
(6, 3, 2016, '2 place'), (14, 3, 2016, 'winner'), (4, 4, 2013, 'winner'), (4, 4, 2015, '4 place'),
(8, 6, 2012, '3 place'), (8, 6, 2016, 'winner');

INSERT INTO Regional_Club_Tournament(regClubTournId, name, regFedId) VALUES(1, 'UEFA Champions League', 1),
(2, 'AFC Champions League', 2), (3, 'Copa Libertadores', 3), (4, 'CONCACAF Champions League', 4),
(5, 'CAF Champions League', 5), (6, 'OFC Champions League', 6), (7, 'UEFA Europa League', 1);

INSERT INTO Regional_Club_Tournament_Result(regClubTournId, clubId, season, result) VALUES(1, 1, 2014, '1/8'),
(1, 3, 2014, 'group'), (1, 4, 2014, 'Europa League'), (7, 4, 2014, '1/4'), (1, 5, 2014, 'winner'),
(1, 6, 2014, '1/2'), (1, 7, 2014, '1/2'), (1, 8, 2014, '1/4'), (1, 1, 2015, '1/8'), (1, 3, 2015, 'group'),
(1, 4, 2015, '1/8'), (1, 5, 2015, '1/4'), (1, 6, 2015, 'winner'), (1, 7, 2015, '1/2'), (1, 8, 2015, '1/4');

INSERT INTO Player(playerId, firstName, lastName, clubId) VALUES(1, 'Cristiano', 'Ronaldo', 6), 
(2, 'Lionel', 'Messi', 5), (3, 'Sergio', 'Ramos', 6), (4, 'Jese', 'Rodrigues', 8),
(5, 'Ngolo', 'Kante', 1), (6, 'Jamie', 'Vardy', 2), (7, 'Igor', 'Akinfeev', 3),
(8, 'Alexander', 'Kerzhakov', 4), (9, 'Tony', 'Kroos', 6), (10, 'Robert', 'Lewandowski', 7),
(11, 'Edinson', 'Cavani', 8);

INSERT INTO Transfer(transferId, playerId, fromClubId, toClubId, price) VALUES(1, 4, 6, 8, 30),
(2, 5, 2, 1, 30), (3, 9, 7, 6, 35);

INSERT INTO Golden_Ball(year, playerId) VALUES(2016, 1), (2015, 2), (2014, 1), (2013, 1), (2012, 2),
(2011, 2), (2010, 2), (2009, 2), (2008, 1);

Функциональные зависимости:
cid -> startYear finishYear
countryId -> countryName natChampId
candId -> firstName lastName
cid candId -> electionDate
countryId WCYear -> WCREsult
natChampId -> natChampName rang
clubId -> name regFedId
clubId natChampSeason -> natChampResult natChampId
regFedId -> regionName regionFederationName regTournId
regTournId -> regTournName
countryId regCountryYear -> regTournResult regTournId
regClubTournId -> regClubTournName
clubId regClubYear -> regClubTournResult regClubTournId
playerId -> firstName lastName
transferId -> price
GBYear -> GoldenBallWinner

Для поиска ключа отношения используем программу:

package ru.ifmo.ctddev.slyusarenko.db.hw3;

import java.io.*;
import java.util.*;

/**
 * @author Maxim Slyusarenko
 * @since 24.10.16
 */
public class Main {

    private static Map<String[], String[]> dependencies = new HashMap<>();
    private static Set<String> attributes = new HashSet<>();

    private static boolean isUpKey(List<String> keyCandidate) {
        Set<String> currentAttributes = new HashSet<>(keyCandidate);
        while (true) {
            int startSize = currentAttributes.size();
            for (Map.Entry<String[], String[]> dependency : dependencies.entrySet()) {
                if (currentAttributes.containsAll(Arrays.asList(dependency.getKey()))) {
                    currentAttributes.addAll(Arrays.asList(dependency.getValue()));
                }
            }
            int finishSize = currentAttributes.size();
            if (startSize == finishSize) {
                break;
            }
        }
        return currentAttributes.size() == attributes.size();
    }

    private static Set<List<String>> computeUpKeys(List<String> currentKey, int deleteIndex) {
        for (int i = deleteIndex; i < currentKey.size(); i++) {
            List<String> keyCandidate = new ArrayList<>(currentKey);
            keyCandidate.remove(i);
            if (isUpKey(keyCandidate)) {
                Set<List<String>> result = computeUpKeys(currentKey, deleteIndex + 1);
                result.addAll(computeUpKeys(keyCandidate, 0));
                return result;
            }
        }
        return new HashSet<>(Collections.singleton(currentKey));
    }

    private static Set<List<String>> computeKeys(Set<List<String>> upKeys) {
        Set<List<String>> keys = new HashSet<>(upKeys);
        for (List<String> key1 : upKeys) {
            for (List<String> key2 : upKeys) {
                if (key1.equals(key2)) {
                    continue;
                }
                if (key1.containsAll(key2)) {
                    keys.remove(key1);
                    continue;
                }
                if (key2.containsAll(key1)) {
                    keys.remove(key2);
                }
            }
        }
        return keys;
    }

    public static void main(String[] args) {
        try (BufferedReader reader = new BufferedReader(new FileReader("dependencies.in"));
             BufferedWriter writer = new BufferedWriter(new FileWriter("dependencies.out"))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("->");
                if (parts.length != 2) {
                    throw new IllegalArgumentException("Wrong dependency");
                }
                String[] left = parts[0].trim().split(" ");
                String[] right = parts[1].trim().split(" ");
                dependencies.put(left, right);
                Collections.addAll(attributes, left);
                Collections.addAll(attributes, right);
            }
            Set<List<String>> upKeys = computeUpKeys(new ArrayList<>(attributes), 0);
            Set<List<String>> keys = computeKeys(upKeys);
            for (List<String> key : keys) {
                for (String elem : key) {
                    writer.write(elem + " ");
                }
                writer.write("\n");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}

В результате выполнения получаем, что {cid, countryId, candId, WCYear, clubId, natChampSeason, 
regCountryYear, regClubYear, playerId, transferId, GBYear} - ключ.
Это ключ и других ключей нет, так как эти атрибуты должны входить в ключ, потому что
они нигде не выводятся, а из них можно вывести все остальные. Значит, это минимальный
по включению надключ => это ключ

Строим неприводимое множество ФЗ:
Приводим:
1) cid -> startYear finishYear
    Нельзя удалить, так как cid нигде не выводится
2) countryId -> countryName natChampId regFedId
    Нельзя удалить, так как countryId нигде не выводится
3) candId -> firstName lastName
    Нельзя удалить, так как candId нигде не выводится
4) cid candId -> electionDate
    Нельзя удалить, так как cid и candId нигде не выводятся
5) countryId WCYear -> WCREsult
    Нельзя удалить, так как countryId и WCYear нигде не выводятся
6) natChampId -> natChampName rang
    Можно удалить, так как natChampId выводится по правилу 2
7) clubId -> name regFedId
    Нельзя удалить, так как clubId нигде не выводится
8) clubId natChampSeason -> natChampResult natChampId
    Нельзя ничего удалить, так как clubId и natChampId нигде не выводятся
9) regFedId -> regionName regionFederationName regTournId
    Можно удалить, так как regFedId выводится по правилу 7
10) regTournId -> regTournName
    Можно удалить, так как regTournId выводится по правилу 9
11) countryId regCountryYear -> regTournResult regTournId
    Нельзя удалить, так как countryId и regCountryYear нигде не выводятся
12) regClubTournId -> regClubTournName
    Можно удалить, так как regClubTournId выводится по правилу 9
13) clubId regClubYear -> regClubTournResult regClubTournId
    Нельзя ничего удалить, так как clubId и regClubYear нигде не выводятся
14) playerId -> firstName lastName
    Нельзя удалить, так как playerId нигде не выводится
15) transferId -> price
    Нельзя удалить, так как transferId нигде не выводится
16) GBYear -> GoldenBallWinner
    Нельзя удалить, так как GBYear нигде не выводится

В итоге получаем такое неприводимое множество функциональных зависимостей:
cid -> startYear finishYear
countryId -> countryName natChampId
candId -> firstName lastName
cid candId -> electionDate
countryId WCYear -> WCREsult
clubId -> name regFedId
clubId natChampSeason -> NatChampResult
countryId regCountryYear -> regTournResult regTournId
clubId regClubYear -> regClubTournResult
playerId -> firstName lastName
transferId -> price
GBYear -> GoldenBallWinner

Нормальные формы:
1) В отношении нет повторяющихся групп, все атрибуты атомарны, у отношения есть ключ => 1 нормальная форма
2) 1 НФ, неключевые атрибуты функционально зависят от ключа в целом => 2 нормальная форма
3) 2 НФ, неключевые атрибуты непосредственно (не транзитивно) зависят от ключей => 3 нормальная форма
4) В каждой нетривиальной функциональной зависимости X -> Y X является надключем => Нормальная форма Бойса-Кодта
5) НФБК и есть простой ключ => 4 нормальная форма

Создадим дополнительные таблицы, в которых будем хранить победителей турниров и сделаем триггеры для
обновления этих таблиц при вставке в таблицы результатов:
1) Победители чемпионатов мира
    CREATE TABLE World_Cup_Winner AS SELECT wcr.year, c.name FROM World_Cup_Result AS wcr NATURAL JOIN Country AS c WHERE wcr.result = 'winner';

    create or replace function onWorldChampionshipResultInserted() returns trigger as $$
        declare countryName varchar(100);
    begin
        if (new.result = 'winner') then
            SELECT name INTO countryName FROM Country WHERE countryId = new.countryId;
            INSERT INTO World_Cup_Winner (year, name) VALUES (new.year, countryName);
        end if;
        return new;
    end$$ language plpgsql;

    create or replace function onWorldChampionshipResultUpdated() returns trigger as $$
        declare countryName varchar(100);
    begin
        if (old.result = 'winner') then
            DELETE FROM World_Cup_Winner WHERE year = old.year;
        end if;
        if (new.result = 'winner') then
            SELECT name INTO countryName FROM Country WHERE countryId = new.countryId;
            INSERT INTO World_Cup_Winner (year, name) VALUES (new.year, countryName);
        end if;
        return new;
    end$$ language plpgsql;

    create or replace function onWorldChampionshipResultDeleted() returns trigger as $$begin
        if (old.result = 'winner') then
            DELETE FROM World_Cup_Winner WHERE year = old.year;
        end if;
        return new;
    end$$ language plpgsql;

    create trigger onWorldCupResultInserted
        after insert on World_Cup_Result for each row execute procedure onWorldChampionshipResultInserted();
    
    create trigger onWorldCupResultDeleted
        after delete on World_Cup_Result for each row execute procedure onWorldChampionshipResultDeleted();
    
    create trigger onWorldCupResultUpdated
        after update on World_Cup_Result for each row execute procedure onWorldChampionshipResultUpdated();

2) Победители международных региональных соревнований
    CREATE TABLE Regional_International_Tournament_Winner AS SELECT rtr.year, rt.name AS tournamentName, 
    c.name AS countryName FROM Regional_Tournament_Result AS rtr NATURAL JOIN Country AS c 
    INNER JOIN Regional_International_Tournament AS rt ON rt.regTournId = rtr.regTournId 
    WHERE rtr.result = 'winner';

    create or replace function onRegionalInternationalTournamentResultInserted() returns trigger as $$
        declare insertCountryName varchar(100);
        declare insertTournamentName varchar(100);
    begin
        if (new.result = 'winner') then
            SELECT name INTO insertCountryName FROM Country WHERE countryId = new.countryId;
            SELECT name INTO insertTournamentName FROM Regional_International_Tournament WHERE regTournId = new.regTournId;
            INSERT INTO Regional_International_Tournament_Winner (year, tournamentName, countryName) VALUES (new.year, insertTournamentName, insertCountryName);
        end if;
        return new;
    end$$ language plpgsql;

    create or replace function onRegionalInternationalTournamentResultUpdated() returns trigger as $$
        declare deleteTournamentName varchar(100);
        declare insertCountryName varchar(100);
        declare insertTournamentName varchar(100);
    begin
        if (old.result = 'winner') then
            SELECT name INTO deleteTournamentName FROM Regional_International_Tournament WHERE regTournId = old.regTournId;
            DELETE FROM Regional_International_Tournament_Winner WHERE year = old.year AND tournamentName = deleteTournamentName;
        end if;
        if (new.result = 'winner') then
            SELECT name INTO insertCountryName FROM Country WHERE countryId = new.countryId;
            SELECT name INTO insertTournamentName FROM Regional_International_Tournament WHERE regTournId = new.regTournId;
            INSERT INTO Regional_International_Tournament_Winner (year, tournamentName, countryName) VALUES (new.year, insertTournamentName, insertCountryName);
        end if;
        return new;
    end$$ language plpgsql;

    create or replace function onRegionalInternationalTournamentResultDeleted() returns trigger as $$
        declare deleteTournamentName varchar(100);
    begin
        if (old.result = 'winner') then
            SELECT name INTO deleteTournamentName FROM Regional_International_Tournament WHERE regTournId = old.regTournId;
            DELETE FROM Regional_International_Tournament_Winner WHERE year = old.year AND tournamentName = deleteTournamentName;
        end if;
        return old;
    end$$ language plpgsql;

    create trigger onRegionalInternationalTournamentResultInserted
        after insert on Regional_Tournament_Result for each row execute procedure onRegionalInternationalTournamentResultInserted();
    
    create trigger onRegionalInternationalTournamentResultDeleted
        after delete on Regional_Tournament_Result for each row execute procedure onRegionalInternationalTournamentResultDeleted();
    
    create trigger onRegionalInternationalTournamentResultUpdated
        after update on Regional_Tournament_Result for each row execute procedure onRegionalInternationalTournamentResultUpdated();

3) Клубы, выигравшие национальные чемпионаты
    CREATE TABLE National_Championship_Winner AS SELECT ncr.season, nc.name AS championshipName, c.name AS clubName 
    FROM National_Championship_Result AS ncr NATURAL JOIN Club AS c INNER JOIN National_Championship AS nc 
    ON ncr.natChampId = nc.natChampId WHERE ncr.place = 1;

    create or replace function onNationalClubTournamentResultInserted() returns trigger as $$
        declare insertClubName varchar(100);
        declare insertTournamentName varchar(100);
    begin
        if (new.place = 1) then
            SELECT name INTO insertClubName FROM Club WHERE clubId = new.clubId;
            SELECT name INTO insertTournamentName FROM National_Championship WHERE natChampId = new.natChampId;
            INSERT INTO National_Championship_Winner (season, championshipName, clubName) VALUES (new.season, insertTournamentName, insertClubName);
        end if;
        return new;
    end$$ language plpgsql;

    create or replace function onNationalClubTournamentResultUpdated() returns trigger as $$
        declare deleteTournamentName varchar(100);
        declare insertClubName varchar(100);
        declare insertTournamentName varchar(100);
    begin
        if (old.place = 1) then
            SELECT name INTO deleteTournamentName FROM National_Championship WHERE natChampId = old.natChampId;
            DELETE FROM National_Championship_Winner WHERE season = old.season AND championshipName = deleteTournamentName;
        end if;
        if (new.place = 1) then
            SELECT name INTO insertClubName FROM Club WHERE clubId = new.clubId;
            SELECT name INTO insertTournamentName FROM National_Championship WHERE natChampId = new.natChampId;
            INSERT INTO National_Championship_Winner (season, championshipName, clubName) VALUES (new.season, insertTournamentName, insertClubName);
        end if;
        return new;
    end$$ language plpgsql;

    create or replace function onNationalClubTournamentResultDeleted() returns trigger as $$
        declare deleteTournamentName varchar(100);
    begin
        if (old.place = 1) then
            SELECT name INTO deleteTournamentName FROM National_Championship WHERE natChampId = old.natChampId;
            DELETE FROM National_Championship_Winner WHERE season = old.season AND championshipName = deleteTournamentName;
        end if;
        return old;
    end$$ language plpgsql;

    create trigger onNationalClubTournamentResultInserted
        after insert on National_Championship_Result for each row execute procedure onNationalClubTournamentResultInserted();
    
    create trigger onNationalClubTournamentResultDeleted
        after delete on National_Championship_Result for each row execute procedure onNationalClubTournamentResultDeleted();
    
    create trigger onNationalClubTournamentResultUpdated
        after update on National_Championship_Result for each row execute procedure onNationalClubTournamentResultUpdated();

4) Клубы, выигравшие международные турниры
    CREATE TABLE Regional_Club_Tournament_Winner AS SELECT rctr.season, rct.name AS tournamentName, c.name AS clubName 
    FROM Regional_Club_Tournament_Result AS rctr NATURAL JOIN Club AS c INNER JOIN Regional_Club_Tournament AS rct 
    ON rctr.regClubTournId = rct.regClubTournId WHERE rctr.result = 'winner';

    create or replace function onRegionalClubTournamentResultInserted() returns trigger as $$
        declare insertClubName varchar(100);
        declare insertTournamentName varchar(100);
    begin
        if (new.result = 'winner') then
            SELECT name INTO insertClubName FROM Club WHERE clubId = new.clubId;
            SELECT name INTO insertTournamentName FROM Regional_Club_Tournament WHERE regClubTournId = new.regClubTournId;
            INSERT INTO Regional_Club_Tournament_Winner (year, tournamentName, clubName) VALUES (new.year, insertTournamentName, insertClubName);
        end if;
        return new;
    end$$ language plpgsql;

    create or replace function onRegionalClubTournamentResultUpdated() returns trigger as $$
        declare deleteTournamentName varchar(100);
        declare insertClubName varchar(100);
        declare insertTournamentName varchar(100);
    begin
        if (old.result = 'winner') then
            SELECT name INTO deleteTournamentName FROM Regional_Club_Tournament WHERE regClubTournId = old.regClubTournId;
            DELETE FROM Regional_Club_Tournament_Winner WHERE year = old.year AND tournamentName = deleteTournamentName;
        end if;
        if (new.result = 'winner') then
            SELECT name INTO insertClubName FROM Club WHERE clubId = new.clubId;
            SELECT name INTO insertTournamentName FROM Regional_Club_Tournament WHERE regClubTournId = new.regClubTournId;
            INSERT INTO Regional_Club_Tournament_Winner (year, tournamentName, clubName) VALUES (new.year, insertTournamentName, insertClubName);
        end if;
        return new;
    end$$ language plpgsql;

    create or replace function onRegionalClubTournamentResultDeleted() returns trigger as $$
        declare deleteTournamentName varchar(100);
    begin
        if (old.result = 'winner') then
            SELECT name INTO deleteTournamentName FROM Regional_Club_Tournament WHERE regClubTournId = old.regClubTournId;
            DELETE FROM Regional_Club_Tournament_Winner WHERE year = old.year AND tournamentName = deleteTournamentName;
        end if;
        return old;
    end$$ language plpgsql;

    create trigger onRegionalClubTournamentResultInserted
        after insert on Regional_Club_Tournament_Result for each row execute procedure onRegionalClubTournamentResultInserted();
    
    create trigger onRegionalClubTournamentResultDeleted
        after delete on Regional_Club_Tournament_Result for each row execute procedure onRegionalClubTournamentResultDeleted();
    
    create trigger onRegionalClubTournamentResultUpdated
        after update on Regional_Club_Tournament_Result for each row execute procedure onRegionalClubTournamentResultUpdated();

Добавим некоторые триггеры с валидацией:
1) Нельзя вставить слишком много одинаковых результатов для данного турнира (например, не может быть 2 победителей)
    a) Чемпионат мира
        create or replace function checkNormalResultsForWorldCup() returns trigger as $$
            declare stageCount int;
            declare teamCount int;
        begin
            select count(*) into stageCount from World_Cup_Result where year = new.year and result = 'group';
            if (stageCount = 32 and new.result = 'group') then
                return null;
            end if;
            select count(*) into stageCount from World_Cup_Result where year = new.year and result = '1/8';
            if (stageCount = 16 and new.result = '1/8') then
                return null;
            end if;
            select count(*) into stageCount from World_Cup_Result where year = new.year and result = '1/4';
            if (stageCount = 8 and new.result = '1/4') then
                return null;
            end if;
            select count(*) into stageCount from World_Cup_Result where year = new.year and result = '4 place';
            if (stageCount = 1 and new.result = '4 place') then
                return null;
            end if;
            select count(*) into stageCount from World_Cup_Result where year = new.year and result = '3 place';
            if (stageCount = 1 and new.result = '3 place') then
                return null;
            end if;
            select count(*) into stageCount from World_Cup_Result where year = new.year and result = '2 place';
            if (stageCount = 1 and new.result = '2 place') then
                return null;
            end if;
            select count(*) into stageCount from World_Cup_Result where year = new.year and result = 'winner';
            if (stageCount = 1 and new.result = 'winner') then
                return null;
            end if;
            select count(*) into teamCount from World_Cup_Result where year = new.year and countryId = new.countryId;
            if (teamCount = 1) then
                return null;
            end if;
            return new;
        end$$ language plpgsql;

        create trigger beforeWorldCupResultInsert before insert on
            World_Cup_Result for each row execute procedure checkNormalResultsForWorldCup();

    b) Международные турниры сборных
        create or replace function checkNormalResultsForRegionalInternationalTournament() returns trigger as $$
            declare stageCount int;
            declare teamCount int;
            declare expectedTournamentId int;
        begin
            select count(*) into stageCount from Regional_Tournament_Result where year = new.year and regTournId = new.regTournId and result = 'group';
            if (new.regTournId = 1 and stageCount = 8) and new.result = 'group') then
                return null;
            end if;
            if (new.regTournId = 4 and stageCount = 4 and new.result = 'group') then
                return null;
            end if;
            if (new.regTournId = 6 and stageCount = 2 and new.result = 'group') then
                return null;
            end if;
            if (new.regTournId <> 1 and new.regTournId <> 4 and stageCount = 8 and new.result = 'group') then
                return null;
            end if;
            if ((new.regTournId <> 1 or new.year < 2016) and new.result = '1/8') then
                return null;
            end if;
            if (new.regTournId = 1 and new.result = '4 place') then
                return null;
            end if;
            if (new.regTournId = 6 and new.result = '1/4') then
                return null;
            end if;
            select count(*) into stageCount from Regional_Tournament_Result where year = new.year and regTournId = new.regTournId and result = '1/8';
            if (stageCount = 8 and new.result = '1/8') then
                return null;
            end if;
            select count(*) into stageCount from Regional_Tournament_Result where year = new.year and regTournId = new.regTournId and result = '1/4';
            if (stageCount = 4 and new.result = '1/4') then
                return null;
            end if;
            select count(*) into stageCount from Regional_Tournament_Result where year = new.year and regTournId = new.regTournId and result = '4 place';
            if (stageCount = 1 and new.result = '4 place') then
                return null;
            end if;
            select count(*) into stageCount from Regional_Tournament_Result where year = new.year and regTournId = new.regTournId and result = '3 place';
            if ((new.regTournId = 1 and stageCount = 2) or (new.regTournId <> 1 and stageCount = 1) and new.result = '3 place') then
                return null;
            end if;
            select count(*) into stageCount from Regional_Tournament_Result where year = new.year and regTournId = new.regTournId and result = '2 place';
            if (stageCount = 1 and new.result = '2 place') then
                return null;
            end if;
            select count(*) into stageCount from Regional_Tournament_Result where year = new.year and regTournId = new.regTournId and result = 'winner';
            if (stageCount = 1 and new.result = 'winner') then
                return null;
            end if;
            select count(*) into teamCount from Regional_Tournament_Result where year = new.year and regTournId = new.regTournId and countryId = new.countryId;
            if (teamCount = 1) then
                return null;
            end if;
            select rit.regTournId into expectedTournamentId from Regional_International_Tournament as rit 
            inner join Regional_Federation as rf on rit.regFedId = rf.regFedId 
            inner join Country as c on rf.regFedId = c.regFedId where c.countryId = new.countryId;
            if (expectedTournamentId <> new.regTournId) then
                return null;
            end if;
            return new;
        end$$ language plpgsql;

        create trigger beforeRegionalInternationalTournamentResultInsert before insert on
            Regional_Tournament_Result for each row execute procedure checkNormalResultsForRegionalInternationalTournament();

    c) Национальные чемпионаты
        
        create or replace function checkNormalResultsForNationalChampionship() returns trigger as $$
            declare placeCount int;
            declare teamCount int;
        begin
            select count(*) into placeCount from National_Championship_Result where season = new.season and place = new.place and natChampId = new.natChampId;
            if (placeCount = 1) then
                return null;
            end if;
            select count(*) into teamCount from National_Championship_Result where season = new.season and clubId = new.clubId and natChampId = new.natChampId;
            if (teamCount = 1) then
                return null;
            end if;
            return new;
        end$$ language plpgsql;

        create trigger beforeNationalChampionshipResultInsert before insert on
            National_Championship_Result for each row execute procedure checkNormalResultsForNationalChampionship();

    d) Международные турниры клубов
        create or replace function checkNormalResultsForRegionalClubTournament() returns trigger as $$
            declare stageCount int;
            declare teamCount int;
        begin
            select count(*) into stageCount from Regional_Club_Tournament_Result where season = new.season and result = 'group' and regClubTournId = new.regClubTournId;
            if (stageCount = 16 and new.result = 'group') then
                return null;
            end if;
            select count(*) into stageCount from Regional_Club_Tournament_Result where season = new.season and result = '1/8' and regClubTournId = new.regClubTournId;
            if (stageCount = 8 and new.result = '1/8') then
                return null;
            end if;
            select count(*) into stageCount from Regional_Club_Tournament_Result where season = new.season and result = '1/4' and regClubTournId = new.regClubTournId;
            if (stageCount = 4 and new.result = '1/4') then
                return null;
            end if;
            select count(*) into stageCount from Regional_Club_Tournament_Result where season = new.season and result = '1/2' and regClubTournId = new.regClubTournId;
            if (stageCount = 2 and new.result = '1/2') then
                return null;
            end if;
            select count(*) into stageCount from Regional_Club_Tournament_Result where season = new.season and result = '2 place' and regClubTournId = new.regClubTournId;
            if (stageCount = 1 and new.result = '2 place') then
                return null;
            end if;
            select count(*) into stageCount from Regional_Club_Tournament_Result where season = new.season and result = 'winner' and regClubTournId = new.regClubTournId;
            if (stageCount = 1 and new.result = 'winner') then
                return null;
            end if;
            select count(*) into teamCount from Regional_Club_Tournament_Result where season = new.season and clubId = new.clubId and regClubTournId = new.regClubTournId;
            if (teamCount = 1) then
                return null;
            end if;
            return new;
        end$$ language plpgsql;


    create trigger beforeRegionalClubTournamentResultInsert before insert on
        Regional_Club_Tournament_Result for each row execute procedure checkNormalResultsForRegionalClubTournament();

Составим некотороые выражения реляционной алгебры и запросы на datalog и sql, оформив их как хранимые процедуры:
    1) По клубу определить его страну
        
        create or replace function getClubCountries() returns table (clubName varchar(100), countryName varchar(100)) as $$
            select distinct cl.name as clubName, co.name as countryName from Club as cl 
                inner join Country as co on cl.countryId = co.countryId;
        $$ language sql;

    2) Все страны, представители которых были в исполнительном комитете
        
        create or replace function getCommiteeCountries() returns table (countryName varchar(100)) as $$
            select distinct name as countryName from Country where countryId in 
                (select countryId from Candidate natural join Commiteeman);
        $$ language sql;

    3) Количество побед определенной страны на чемпионате мира
        
        create or replace function getWorldCupWins(in id int) returns bigint as $$
            select count(*) from World_Cup_Result where countryId = id and result = 'winner';
        $$ language sql;

    4) Количество побед каждой из стран на чемпионате мира
        
        create or replace function getWorldCupWinsForEveryCountry() returns table (countryName varchar(100), wins bigint) as $$
            select co.name as countryName, count(*) as wins from Country as co natural join World_Cup_Result as wcr
                where wcr.result = 'winner' group by co.name order by wins;
        $$ language sql;

    5) Количество золотых мячей у конкретного игрока

        create or replace function getGoldenBallsForPlayer(in id int) returns bigint as $$
            select count(*) from Golden_Ball where playerId = id;
        $$ language sql;

    6) Количество золотых мячей у каждого игрока
        
        create or replace function getGoldenBallsForEveryPlayer() returns table (firstName varchar(100), lastName varchar(100), goldenBalls bigint) as $$
            select firstName, lastName, count(*) as goldenBalls from Player
                natural join Golden_Ball group by (firstName, lastName) order by goldenBalls;
        $$ language sql;

    7) Региональная федерация, к которой относится клуб
        
        create or replace function getRegionalFederationForClub(in id int) returns varchar(100) as $$
            select rf.name from Regional_Federation as rf inner join Country as co 
                on rf.regFedId = co.regFedId inner join Club as cl on cl.countryId = co.countryId
                where cl.clubId = id;
        $$ language sql;

    8) Все страны, которые выигрывали чемпионат мира
        
        create or replace function getCountriesWhichWinsWorldCup() returns table (countryName varchar(100)) as $$
            select distinct co.name as countryName from Country as co where co.countryId in 
                (select countryId from World_Cup_Result where result = 'winner');
        $$ language sql;

    9) Все страны, которые выигрывали региональные турниры
        
        create or replace function getCountriesWhichWinsRegionalTournaments() returns table (countryName varchar(100), tournamentName varchar(100)) as $$
            select distinct co.name as countryName, rit.name as tournamentName from Country as co 
                cross join Regional_International_Tournament as rit where (co.countryId, rit.regTournId) in 
                (select countryId, regTournId from Regional_Tournament_Result where result = 'winner');
        $$ language sql;

    10) Все клубы, которые выигрывали национальные чемпионаты
        
        create or replace function getClubsWhichWinsNationalChampionships() returns table (clubName varchar(100), tournamentName varchar(100)) as $$
            select distinct c.name as clubName, nc.name as tournamentName from Club as c 
                cross join National_Championship as nc where (c.clubId, nc.natChampId) in 
                (select clubId, natChampId from National_Championship_Result where place = 1);
        $$ language sql;

    11) Все клубы, которые выигрывали региональные турниры
        
        create or replace function getClubsWhichWinsRegionalTournaments() returns table (clubName varchar(100), tournamentName varchar(100)) as $$
            select distinct c.name as clubName, rct.name as tournamentName from Club as c 
                cross join Regional_Club_Tournament as rct where (c.clubId, rct.regClubTournId) in 
                (select clubId, regClubTournId from Regional_Club_Tournament_Result where result = 'winner');
        $$ language sql;

    12) Клубы, потратившие наибольшую сумму на трансферы
        
        create or replace function getClubsWithMaxMoneyToTransfers() returns table (clubName varchar(100), money bigint) as $$
            select distinct c.name as clubName, sum(t.price) as money from Club as c inner join Transfer as t
                on t.toClubId = c.clubId group by c.name order by money desc;
        $$ language sql;

    13) Клубы, выручившие наибольшую сумму с трансферов
        
        create or replace function getClubsWithMaxMoneyFromTransfers() returns table (clubName varchar(100), money bigint) as $$
            select distinct c.name as clubName, sum(t.price) as money from Club as c inner join Transfer as t
                on t.fromClubId = c.clubId group by c.name order by money desc;
        $$ language sql;
        
Сделаем хранимые процедуры для некоторых операций:
    1) Трансфер игрока
        
        create or replace function performTransfer(in perfTransferId int, in player int, in fromClub int, in toClub int, in price int) returns void as $$
            insert into Transfer (transferId, playerId, fromClubId, toClubId, price) 
                values (perfTransferId, player, fromClub, toClub, price);
            update Player set clubId = toClub where playerId = player;
        $$ language sql;

    2) Смена страны, которую представляет клуб
        
        create or replace function changeClubCountry(in club int, in newCountry int) returns void as $$
            update Club set countryId = newCountry where clubId = club;
        $$ language sql;

    3) Добавление результата клуба в национальном чемпионате
        
        create or replace function addClubNationalChampionshipResult(in club int, in placeToAdd int, in season int, in champRang int) returns void as $$
            declare championshipId int;
        begin
            select natChampId into championshipId from National_Championship as nc inner join Country as co 
            on nc.countryId = co.countryId inner join Club as cl on cl.countryId = co.countryId 
            where nc.rang = champRang and cl.clubId = club;
            insert into National_Championship_Result (natChampId, clubId, season, place) 
                values (championshipId, club, season, placeToAdd);
        end$$ language plpgsql;

    4) Смена федерации, в которой зарегистрирована страна
        
        create or replace function changeCountryFederation(in country int, in newFederation int) returns void as $$
            update Country set regFedId = newFederation where countryId = country;
        $$ language sql;

    5) Добавление результата страны в региональном турнире
        
        create or replace function addCountryResultInRegionalTournament(in country int, in resultToAdd varchar(100), in yearToAdd int) returns void as $$
            declare championshipId int;
        begin
            select regTournId into championshipId from Regional_International_Tournament as rit 
            inner join Regional_Federation as rf on rit.regFedId = rf.regFedId 
            inner join Country as co on co.regFedId = rf.regFedId where co.countryId = country;
            insert into Regional_Tournament_Result (regTournId, countryId, year, result) 
                values (championshipId, country, yearToAdd, resultToAdd);
        end$$ language plpgsql;