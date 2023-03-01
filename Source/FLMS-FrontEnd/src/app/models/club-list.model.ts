import { ClubDetail } from './club-detail.model';

export class ClubList {
    public total: number;
    public clubs: ClubDetail[];

    constructor(
        total: number,
        clubs: ClubDetail[]
    ) {
        this.total = total,
        this.clubs = clubs
    }
}