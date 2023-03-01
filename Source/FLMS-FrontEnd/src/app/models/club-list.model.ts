import { ClubDetail } from './club-detail.model';

export interface ClubList {
    total: number;
    clubs: ClubDetail[];
}