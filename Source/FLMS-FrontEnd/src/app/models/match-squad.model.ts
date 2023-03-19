export interface Squad {
    squad: MatchSquad;
}

export class Squad implements Squad {
    constructor(
        squad: MatchSquad
    ) {
        this.squad = squad;
    }
}

export interface MatchSquad {
    squadId: number;
    matchId: number;
    isHome: boolean;
    noPlayerSquad: number;
    startingSquad: SquadPosition[];
    substitution: SquadPosition[];
}

export class MatchSquad implements MatchSquad {
    constructor(
        squadId: number,
        matchId: number,
        isHome: boolean,
        noPlayerSquad: number,
        startingSquad: SquadPosition[],
        substitution: SquadPosition[]
    ) {
        this.squadId = squadId;
        this.matchId = matchId;
        this.isHome = isHome;
        this.noPlayerSquad = noPlayerSquad;
        this.startingSquad = startingSquad;
        this.substitution = substitution;
    }
}

export interface SquadPosition {
    squadPositionId: number;
    squadId: number;
    positionKey: string;
    playerId: number;
    playerName: string;
    playerAvatar: string;
}

export class SquadPosition implements SquadPosition {
    constructor(
        squadPositionId: number,
        squadId: number,
        positionKey: string,
        playerId: number,
        playerName: string,
        playerAvatar: string
    ) {
        this.squadPositionId = squadPositionId;
        this.squadId = squadId;
        this.positionKey = positionKey;
        this.playerId = playerId;
        this.playerName = playerName;
        this.playerAvatar = playerAvatar;
    }
}