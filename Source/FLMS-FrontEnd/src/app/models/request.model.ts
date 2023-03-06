export interface Request {
    requestId: number,
    leagueId: number,
    clubId: number,
    leagueName: string,
    clubName: string,
    requestType: string,
    requestStatus: string,
    requestDate: Date,
    canCancel: boolean,
    canResponse: boolean
}

export class Request implements Request {
    constructor(
        requestId: number,
        leagueId: number,
        clubId: number,
        leagueName: string,
        clubName: string,
        requestType: string,
        requestStatus: string,
        requestDate: Date,
        canCancel: boolean,
        canResponse: boolean
    ) {
        this.requestId = requestId;
        this.leagueId = leagueId;
        this.clubId = clubId;
        this.leagueName = leagueName;
        this.clubName = clubName;
        this.requestType = requestType;
        this.requestStatus = requestStatus;
        this.requestDate = requestDate;
        this.canCancel = canCancel;
        this.canResponse = canResponse;
    }
}