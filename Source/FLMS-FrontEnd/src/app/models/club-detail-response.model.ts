import { ClubDetail } from './club-detail.model';

export interface ClubList {
    total: number;
    clubs: ClubDetail[];
}

export class ClubList implements ClubList {
    constructor(
        total: number,
        clubs: ClubDetail[]
    ) {
        this.total = total;
        this.clubs = clubs;
    }
}