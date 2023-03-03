import { MatchSchedule } from "./match-schedule.model";


export interface MatchScheduleResponse {
    listMatch: MatchSchedule[];

}

export class MatchScheduleResponse implements MatchScheduleResponse {
    constructor(
        listMatch: MatchSchedule[]
    ) {
        this.listMatch = listMatch;
    }
}