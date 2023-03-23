
export interface ClubLeagueHistory {
    leagueId: number,
    leagueName: string,
    joinedDate: Date,
    won: number,
    draw: number,
    loss: number,
    goal: number,
    rank: string
}

export class ClubLeagueHistory implements ClubLeagueHistory {
    constructor(
        leagueId: number,
        leagueName: string,
        joinedDate: Date,
        won: number,
        draw: number,
        loss: number,
        goal: number,
        rank: string
    ) {
        this.leagueId = leagueId;
        this.leagueName = leagueName;
        this.joinedDate = joinedDate;
        this.won =won;
        this.draw = draw;
        this.loss = loss;
        this.goal = goal;
        this.rank =rank;
    }



}