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
    matchDate: Date,
    isFinish: boolean,

    away: Club,
    home: Club
}

export class MatchSchedule implements MatchSchedule {
    constructor(
        matchId: number,
        leagueId: number,
        matchDate: Date,
        isFinish: boolean,

        away: Club,
        home: Club
    ) {
        this.matchId = matchId;
        this.leagueId = leagueId;
        this.matchDate = matchDate;
        this.isFinish = isFinish;
        this.away = away;
        this.home = home;

    }
}