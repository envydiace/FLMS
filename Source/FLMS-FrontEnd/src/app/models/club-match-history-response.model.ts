import { MatchDetail } from "./match-detail.model";

export interface ClubMatchHistoryResponse{
    listMatch: MatchDetail[]
}

export class ClubMatchHistoryResponse implements ClubMatchHistoryResponse{
    constructor(
        listMatch: MatchDetail[]
    ){
        this.listMatch= listMatch;
    }
}