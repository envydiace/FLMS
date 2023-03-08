import { ClubListByLeague } from "./club-list-by-league.model";

export interface ClubListByLeagueResponse{
    clubs: ClubListByLeague[];
}

export class ClubListByLeagueResponse implements ClubListByLeagueResponse{
    constructor(
        clubs: ClubListByLeague[]
    ){
        this.clubs = clubs;
    }
}