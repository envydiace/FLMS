import { LeagueDetail } from "./league-detail.model";

export interface LeagueList{
    total: number;
    leagues: LeagueDetail[];
}

export class LeagueList{
    constructor(
        total: number,
        leagues: LeagueDetail[]
    
    ){
        this.total = total;
        this.leagues = leagues;
    }
}



