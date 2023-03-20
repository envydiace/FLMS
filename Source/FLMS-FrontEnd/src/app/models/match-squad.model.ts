export interface MatchSquad {
    messageCode: string;
    message: string;
    squadId: number;
    matchId: number;
    isHome: boolean;
    ownClub: ClubOfSquad;
    against: ClubOfSquad;
    leagueName: string;
    matchDate: string;
    matchTime: string;
    round: string;
    stadium: string;
    noPlayerSquad: number;
    maxNoPlayerSub: number;
    squadPositions: SquadPosition[];
    unSquadPositions: SquadPosition[];
}

export class MatchSquad implements MatchSquad {
    constructor(
        squadId: number,
        matchId: number,
        isHome: boolean,
        noPlayerSquad: number,
        squadPositions: SquadPosition[],
        unSquadPositions: SquadPosition[]
    ) {
        this.squadId = squadId;
        this.matchId = matchId;
        this.isHome = isHome;
        this.noPlayerSquad = noPlayerSquad;
        this.squadPositions = squadPositions;
        this.unSquadPositions = unSquadPositions;
    }
}

export interface ClubOfSquad {
    clubId: number;
    clubName: string;
    logo: string;
}

export class ClubOfSquad implements ClubOfSquad {
    constructor(
        clubId: number,
        clubName: string,
        logo: string
    ) {
        this.clubId = clubId;
        this.clubName = clubName;
        this.logo = logo;
    }
}

export interface SquadPosition {
    squadPositionId: number;
    squadId: number;
    positionKey: string;
    playerId: number;
    playerName: string;
    playerAvatar: string;
    xAxis: number;
    yAxis: number;
}

export class SquadPosition implements SquadPosition {
    constructor(
        squadPositionId: number,
        squadId: number,
        positionKey: string,
        playerId: number,
        playerName: string,
        playerAvatar: string,
        xAxis: number,
        yAxis: number
    ) {
        this.squadPositionId = squadPositionId;
        this.squadId = squadId;
        this.positionKey = positionKey;
        this.playerId = playerId;
        this.playerName = playerName;
        this.playerAvatar = playerAvatar;
        this.xAxis = xAxis;
        this.yAxis = yAxis;
    }
}

export interface UpdateSquad {
    squadId: number;
    mains: number[];
    subs: number[];
}

export class UpdateSquad implements UpdateSquad {
    constructor(
        squadId: number,
        mains: number[],
        subs: number[]
    ) {
        this.squadId = squadId;
        this.mains = mains;
        this.subs = subs;
    }
}