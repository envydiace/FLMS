export interface FeeDetail {
    leagueFeeId: number,
    leagueId: number,
    expenseKey: string,
    expenseName: string,
    cost: number,
    isActual: boolean,
    feeType: string,
}


export class FeeDetail implements FeeDetail {
    constructor(
        leagueFeeId: number,
        leagueId: number,
        expenseKey: string,
        expenseName: string,
        cost: number,
        isActual: boolean,
        feeType: string,
    ) {
        this.leagueFeeId = leagueFeeId;
        this.leagueId = leagueId;
        this.expenseKey = expenseKey;
        this.expenseName = expenseName;
        this.cost = cost;
        this.isActual = isActual;
        this.feeType = feeType;
    }
}



export interface LeagueClubFee {
    leagueId: number;
    clubId: number;
    evidence: string;

}

export class LeagueClubFee implements LeagueClubFee {
    constructor(
        leagueId: number,
        clubId: number,
        evidence: string,
    ) {
        this.leagueId = leagueId;
        this.clubId = clubId;
        this.evidence = evidence;
    }
}

export interface ListFees {
    expenseName: string,
    cost: number,
    feeType: string
}

export class ListFees implements ListFees {
    constructor(
        expenseName: string,
        cost: number,
        feeType: string
    ) {
        this.expenseName = expenseName;
        this.cost = cost;
        this.feeType = feeType;
    }
}


export interface AddLeagueFee {
    leagueId: number,
    isActual: boolean,
    listFees: ListFees[]
}

export class AddLeagueFee implements AddLeagueFee {
    constructor(
        leagueId: number,
        isActual: boolean,
        listFees: ListFees[]

    ) {
        this.leagueId = leagueId;
        this.isActual = isActual;
        this.listFees = listFees;
    }
}