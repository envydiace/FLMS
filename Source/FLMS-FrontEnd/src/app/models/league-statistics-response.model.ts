import { LeagueStanding, TopAssist, TopScorer } from "./league-statistics.model";

export interface LeagueStatisticResponse{
    messageCode:string,
    message:string,
    leagueStanding: LeagueStanding[],
    topScore: TopScorer[],
    topAssist: TopAssist[]
}

export class LeagueStatisticResponse implements LeagueStatisticResponse{
    constructor(
        messageCode:string,
        message:string,
        leagueStanding: LeagueStanding[],
        topScore: TopScorer[],
        topAssist: TopAssist[]
    ){
        this.messageCode = messageCode;
        this.message = message;
        this.leagueStanding = leagueStanding;
        this.topScore = topScore;
        this.topAssist = topAssist;
    }
}