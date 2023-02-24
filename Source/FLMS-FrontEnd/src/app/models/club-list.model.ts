import { ClubDetail } from './club-detail.model';

export class ClubList {
    private total: number;
    private clubs: ClubDetail[];

    constructor(
        total: number,
        clubs: ClubDetail[]
    ) {
        this.total = total,
        this.clubs = clubs
    }
}