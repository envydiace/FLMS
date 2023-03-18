export interface leaguePrize {
    expenseKey: string,
    expenseName: string,
    cost: number
}

export class leaguePrize implements leaguePrize {
    constructor(
        expenseKey: string,
        expenseName: string,
        cost: number
    ) {
        this.expenseKey = expenseKey;
        this.expenseName = expenseName;
        this.cost = cost;
    }
}

export interface leagueFee {
    expenseName: string,
    cost: number
}

export class leagueFee implements leagueFee {
    constructor(
        expenseName: string,
        cost: number
    ) {
        this.expenseName = expenseName;
        this.cost = cost;
    }
}