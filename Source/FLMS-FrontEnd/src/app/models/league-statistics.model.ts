export interface LeagueStanding {
    standing: number,
    clubName: string,
    pl: number,
    won: number,
    draw: number,
    loss: number,
    goalsFor: number,
    goalsAgainst: number,
    gd: number,
    point: number,
    history: string[]
}

export class LeagueStanding implements LeagueStanding {
    constructor(
        standing: number,
        clubName: string,
        pl: number,
        won: number,
        draw: number,
        loss: number,
        goalsFor: number,
        goalsAgainst: number,
        gd: number,
        point: number,
        history: string[]
    ) {
        this.standing = standing;
        this.clubName = clubName;
        this.pl = pl;
        this.won = won;
        this.draw = draw;
        this.loss = loss;
        this.goalsFor = goalsFor;
        this.goalsAgainst = goalsAgainst;
        this.gd = gd;
        this.point = point;
        this.history = history;
    }
}

export interface TopScorer {
    playerId: number,
    playerName: string,
    avatar: string,
    record: number,
    clubName: string,
    clubLogo: string
}

export class TopScorer implements TopScorer {
    constructor(
        playerId: number,
        playerName: string,
        avatar: string,
        record: number,
        clubName: string,
        clubLogo: string
    ) {
        this.playerId = playerId;
        this.playerName = playerName;
        this.avatar = avatar;
        this.record = record;
        this.clubName = clubName;
        this.clubLogo = clubLogo;
    }

}

export interface TopAssist {
    playerId: number,
    playerName: string,
    avatar: string,
    record: number,
    clubName: string,
    clubLogo: string
}

export class TopAssist implements TopAssist {
    constructor(
        playerId: number,
        playerName: string,
        avatar: string,
        record: number,
        clubName: string,
        clubLogo: string
    ) {
        this.playerId = playerId;
        this.playerName = playerName;
        this.avatar = avatar;
        this.record = record;
        this.clubName = clubName;
        this.clubLogo = clubLogo;
    }
}