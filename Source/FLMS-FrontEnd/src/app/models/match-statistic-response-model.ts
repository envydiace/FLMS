import { ClubStats } from "./match-statistics-model";

export interface MatchStatisticsResponse {
    messageCode: string;
    message: string;
    matchId: number;
    home: ClubStats;
    away: ClubStats;
}

export class MatchStatisticsResponse implements MatchStatisticsResponse {
    constructor(
        messageCode: string,
        message: string,
        matchId: number,
        home: ClubStats,
        away: ClubStats
    ) {
        this.messageCode = messageCode;
        this.message = message;
        this.matchId = matchId;
        this.home = home;
        this.away = away;
    }
}