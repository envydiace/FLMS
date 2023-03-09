
export interface MatchDetail {
    matchId: number;
    leagueId: number;
    leagueName: string;
    round: string;
    stadium: string;
    matchDate: string;
    matchTime: string;
    isFinish: boolean;
    away: MatchClub;
    home: MatchClub;
}

export class MatchDetail implements MatchDetail {
    constructor(
        matchId: number,
        leagueId: number,
        leagueName: string,
        round: string,
        stadium: string,
        matchDate: string,
        matchTime: string,
        isFinish: boolean,
        away: MatchClub,
        home: MatchClub
    ) {
        this.matchId = matchId;
        this.leagueId = leagueId;
        this.leagueName = leagueName;
        this.round = round;
        this.stadium = stadium;
        this.matchDate = matchDate;
        this.matchTime = matchTime;
        this.isFinish = isFinish;
        this.away = away;
        this.home = home;
    }
}



export interface MatchClub {
    clubId: number;
    name: string;
    logo: string;
    score: number;
}

export class MatchClub implements MatchClub {
    constructor(
        clubId: number,
        name: string,
        logo: string,
        score: number
    ){
      this.clubId = clubId;
      this.name = name;
      this.logo = logo;
      this.score = score;
    }
}
