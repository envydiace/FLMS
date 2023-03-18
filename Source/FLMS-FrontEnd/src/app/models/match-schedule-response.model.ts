import { MatchSchedule } from "./match-schedule.model";
import { ClubMatchSchedule } from "./match-schedule.model";


export interface MatchScheduleResponse {

    messageCode: string,
    message: string,
    listMatch: MatchSchedule[];

}

export class MatchScheduleResponse implements MatchScheduleResponse {
    constructor(
        messageCode: string,
        message: string,
        listMatch: MatchSchedule[]
    ) {
        this.messageCode = messageCode;
        this.message = message;
        this.listMatch = listMatch;
    }
}


export interface ClubMatchScheduleResponse {
    messageCode: string;
    message: string;
    listMatch: ClubMatchSchedule[]
}

export class ClubMatchScheduleResponse implements ClubMatchScheduleResponse {
    constructor(
        messageCode: string,
        message: string,
        listMatch: ClubMatchSchedule[]
    ) {
        this.messageCode = messageCode,
            this.message = message,
            this.listMatch = listMatch;
    }
}