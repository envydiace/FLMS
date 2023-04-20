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
    startingSquad: SquadPosition[];
    substitution: SquadPosition[];
    unSquadPositions: SquadPosition[];
}

export class MatchSquad implements MatchSquad {
    constructor(
        squadId: number,
        matchId: number,
        isHome: boolean,
        noPlayerSquad: number,
        squadPositions: SquadPosition[],
        startingSquad: SquadPosition[],
        substitution: SquadPosition[],
        unSquadPositions: SquadPosition[]
    ) {
        this.squadId = squadId;
        this.matchId = matchId;
        this.isHome = isHome;
        this.noPlayerSquad = noPlayerSquad;
        this.squadPositions = squadPositions;
        this.startingSquad = startingSquad;
        this.substitution = substitution;
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
    coordinate: Coordinate;
}

export class SquadPosition implements SquadPosition {
    constructor(
        squadPositionId: number,
        squadId: number,
        positionKey: string,
        playerId: number,
        playerName: string,
        playerAvatar: string,
        coordinate: Coordinate
    ) {
        this.squadPositionId = squadPositionId;
        this.squadId = squadId;
        this.positionKey = positionKey;
        this.playerId = playerId;
        this.playerName = playerName;
        this.playerAvatar = playerAvatar;
        this.coordinate = coordinate;
    }
}

export interface UpdateSquad {
    squadId: number;
    mains: UpdateCoordinate[];
    subs: UpdateCoordinate[];
}

export class UpdateSquad implements UpdateSquad {
    constructor(
        squadId: number,
        mains: UpdateCoordinate[],
        subs: UpdateCoordinate[]
    ) {
        this.squadId = squadId;
        this.mains = mains;
        this.subs = subs;
    }
}

export class UpdateCoordinate {
    playerId: number;
    x: number;
    y: number;

    constructor(
        playerId: number,
        x: number,
        y: number
    ) {
        this.playerId = playerId;
        this.x = x;
        this.y = y;
    }
}

export interface ViewMatchSquad {
    home: MatchSquad;
    away: MatchSquad;
}

export class ViewMatchSquad implements ViewMatchSquad {
    constructor(
        home: MatchSquad,
        away: MatchSquad
    ) {
        this.home = home;
        this.away = away;
    }
}

export class Coordinate {
    x: number;
    y: number;

    constructor(
        x: number,
        y: number
    ) {
        this.x = x;
        this.y = y;
    }
}