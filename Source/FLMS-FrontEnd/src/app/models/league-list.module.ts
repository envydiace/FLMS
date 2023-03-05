import { LeagueDetail } from "./league-detaild.model";

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


export interface LeagueListbyUser {
    LeaguesByUser: LeagueListbyUser[];
}

export class LeagueListbyUser implements LeagueListbyUser {
    constructor(
        LeaguesByUser: LeagueListbyUser[]

    ) {
        this.LeaguesByUser = LeaguesByUser;
    }
}
