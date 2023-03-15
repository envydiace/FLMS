export interface FeeDetail{
    leagueFeeId: number,
    leagueId: number,
    expenseKey: string,
    expenseName: string,
    cost: number,
    isActual: boolean,
    feeType:string,
}


export class FeeDetail implements FeeDetail{
    constructor(
        leagueFeeId: number,
        leagueId: number,
        expenseKey: string,
        expenseName: string,
        cost: number,
        isActual: boolean, 
        feeType:string,
    ){
        this.leagueFeeId = leagueFeeId;
        this.leagueId = leagueId;
        this.expenseKey = expenseKey;
        this.expenseName = expenseName;
        this.cost = cost;
        this.isActual = isActual;
        this.feeType = feeType;
    }
}



export interface LeagueClubFee{
    leagueId: number;
    clubId: number;
    evidence: string;

}

export class LeagueClubFee implements LeagueClubFee{
    constructor(
        leagueId: number,
        clubId: number,
        evidence: string,
    ){
        this.leagueId = leagueId;
        this.clubId = clubId;
        this.evidence = evidence;
    }
}