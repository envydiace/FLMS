export interface Club {
    clubId: number,
    name: string,
    logo: string
}

export class Club implements Club {
    constructor(
        clubId: number,
        name: string,
        logo: string
    ) {
        this.clubId = clubId;
        this.name = name;
        this.logo = logo;
    }
}

export interface MatchSchedule {
    matchId: number,
    leagueId: number,
    leagueName: string,
    round: string,
    stadium: string,
    matchDate: string,
    matchTime: string,
    isFinish: boolean,
    away: Club,
    home: Club
}

export class MatchSchedule implements MatchSchedule {
    constructor(
        matchId: number,
        leagueId: number,
        leagueName: string,
        round: string,
        stadium: string,
        matchDate: string,
        matchTime: string,
        isFinish: boolean,

        away: Club,
        home: Club
    ) {
        this.matchId = matchId;
        this.leagueId = leagueId;
        this.leagueName = leagueName;
        this.round = round;
        this.stadium = stadium;
        this.matchDate = matchDate;
        this.matchTime = matchTime
        this.isFinish = isFinish;
        this.away = away;
        this.home = home;

    }
}

export interface ClubMatchSchedule {
    matchId: number,
    leagueId: number,
    leagueName: string,
    against: string,
    matchDate: Date,
    matchTime: Date,
    isFinish: boolean,
    ha: string,
    round: string,
    stadium: string
}

export class ClubMatchSchedule implements ClubMatchSchedule {
    constructor(
        matchId: number,
        leagueId: number,
        leagueName: string,
        against: string,
        matchDate: Date,
        matchTime: Date,
        isFinish: boolean,
        ha: string,
        round: string,
        stadium: string
    ) {
        this.matchId = matchId,
            this.leagueId = leagueId,
            this.leagueName = leagueName,
            this.against = against,
            this.matchDate = matchDate,
            this.matchTime = matchTime,
            this.isFinish = isFinish,
            this.ha = ha,
            this.round = round,
            this.stadium = stadium
    }
}