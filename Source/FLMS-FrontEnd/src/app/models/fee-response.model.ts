import { FeeDetail } from "./fee-detail.model";


export interface LeagueFeeResponse {
    messageCode: string,
    message: string,
    plan: FeeDetail[],
    actual: FeeDetail[],
}

export class LeagueFeeResponse implements LeagueFeeResponse {
    constructor(
        messageCode: string,
        message: string,
        plan: FeeDetail[],
        actual: FeeDetail[],
    ) {
        this.messageCode = messageCode;
        this.message = message;
        this.plan = plan;
        this.actual = actual;
    }
}


export interface LeagueClubFeeResponse {
    messageCode: string,
    message: string,
    plan: FeeDetail[],
    total: number,
    noParticipate: number,
    leagueName: string,
    clubName: string,
    logo: string
}
export class LeagueClubFeeResponse implements LeagueClubFeeResponse {
    constructor(
        messageCode: string,
        message: string,
        plan: FeeDetail[],
        total: number,
        noParticipate: number,
        leagueName: string,
        clubName: string,
        logo: string
    ) {
        this.messageCode = messageCode,
            this.message = message,
            this.plan = plan,
            this.total = total,
            this.noParticipate = noParticipate,
            this.leagueName = leagueName,
            this.clubName = clubName,
            this.logo = logo
    }
}

export interface FeeDetailResponse {
    messageCode: string,
    message: string,
    feeInfo: FeeDetail
}

export class FeeDetailResponse implements FeeDetailResponse {
    constructor(
        messageCode: string,
        message: string,
        feeInfo: FeeDetail
    ) {
        this.messageCode = messageCode;
        this.message = message;
        this.feeInfo = feeInfo;
    }
}