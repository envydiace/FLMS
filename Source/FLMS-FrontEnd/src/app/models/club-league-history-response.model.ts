import { ClubLeagueHistory } from "./../models/club-league-history.model";

export interface ClubLeagueHistoryResponse{
    clubLeagueHistory: ClubLeagueHistory[]
}

export class ClubLeagueHistoryResponse implements ClubLeagueHistoryResponse{
    constructor(
        clubLeagueHistory: ClubLeagueHistory[]
    ){
        this.clubLeagueHistory= clubLeagueHistory;
    }
}