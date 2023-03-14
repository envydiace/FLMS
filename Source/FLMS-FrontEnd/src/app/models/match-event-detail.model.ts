import {Player} from './../models/player.model'

export interface MatchEvent {
    matchEventId: number,
    matchId: number,
    eventType: string,
    eventTime: number,
    isHome: boolean,
    main: Player,
    sub: Player,
}


export class MatchEvent implements MatchEvent {
    constructor(
        matchEventId: number,
        matchId: number,
        eventType: string,
        eventTime: number,
        isHome: boolean,
        main: Player,
        sub: Player

    ) {
        this.matchEventId = matchEventId;
        this.matchId = matchId;
        this.eventType = eventType;
        this.eventTime = eventTime;
        this.isHome = isHome;
        this.main = main;
        this.sub = sub
    }
}