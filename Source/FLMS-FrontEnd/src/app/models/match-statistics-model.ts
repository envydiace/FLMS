
export interface MatchStats {
    home: ClubStats;
    away: ClubStats;
}
export class MatchStats implements MatchStats {
    constructor(
        home: ClubStats,
        away: ClubStats
    ) {
        this.home = home;
        this.away = away
    }
}


export interface ClubStats {
    matchId: number;
    isHome: boolean;
    shot: number;
    shotOnTarget: number;
    conner: number;
    foul: number;
    offside: number;
    yellowCard: number;
    redCard: number
}

export class ClubStats implements ClubStats {
    constructor(
        matchId: number,
        isHome: boolean,
        shot: number,
        shotOnTarget: number,
        conner: number,
        foul: number,
        offside: number,
        yellowCard: number,
        redCard: number
    ) {
        this.matchId = matchId;
        this.isHome = isHome;
        this.shot = shot;
        this.shotOnTarget = shotOnTarget;
        this.conner = conner;
        this.foul = foul;
        this.offside = offside;
        this.yellowCard = yellowCard;
        this.redCard = redCard
    }
}
    export interface UpdateStats{
        matchId: number;
        home: ClubStats;
        away: ClubStats;
    }
