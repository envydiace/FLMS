export interface FeeDetail{
    leagueId: number,
    expenseKey: string,
    expenseName: string,
    cost: number,
    isActual: boolean
}


export class FeeDetail implements FeeDetail{
    constructor(
        leagueId: number,
        expenseKey: string,
        expenseName: string,
        cost: number,
        isActual: boolean 
    ){
        this.leagueId = leagueId;
        this.expenseKey = expenseKey;
        this.expenseName = expenseName;
        this.cost = cost;
        this.isActual = isActual;
    }
}