import { Player } from './../models/player.model'

export interface MatchEvent {
    matchEventId: number,
    matchId: number,
    eventType: string,
    eventTime: number,
    isHome: boolean,
    main: Player,
    sub: Player,
    clubId: number,
}


export class MatchEvent implements MatchEvent {
    constructor(
        matchEventId: number,
        matchId: number,
        eventType: string,
        eventTime: number,
        isHome: boolean,
        main: Player,
        sub: Player,
        clubId: number,
    ) {
        this.matchEventId = matchEventId;
        this.matchId = matchId;
        this.eventType = eventType;
        this.eventTime = eventTime;
        this.isHome = isHome;
        this.main = main;
        this.sub = sub;
        this.clubId = clubId;
    }
}


export interface AddMatchEvent {
    mainId: number,
    subId: number,
    matchId: number,
    eventType: string,
    eventTime: number,
    clubId: number,
    mainName: string,
    subName: string,
    clubName: string,
    isHome: boolean,
}

export class AddMatchEvent implements AddMatchEvent {
    constructor(
        mainId: number,
        subId: number,
        matchId: number,
        eventType: string,
        eventTime: number,
        clubId: number,
        mainName: string,
        subName: string,
        clubName: string,
        isHome: boolean
    ) {
        this.mainId = mainId;
        this.subId = subId;
        this.matchId = matchId;
        this.eventType = eventType;
        this.eventTime = eventTime;
        this.clubId = clubId;
        this.mainName = mainName;
        this.subName = subName;
        this.clubName = clubName;
        this.isHome = isHome;
    }
}