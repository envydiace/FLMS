

export interface ClubDetail {
    id: number;
    clubName: string;
    managerName: string;
    phone: number;
    facebook: string;
    email: string;
    wins: number;
    loses: number;
    draws: number;
}

export class ClubDetail implements ClubDetail{
    constructor(
        id: number,
        clubName: string,
        managerName: string,
        phone: number,
        facebook: string,
        email: string,
        wins: number,
        loses: number,
        draws: number
    ) {
        this.id = id;
        this.clubName = clubName;
        this.managerName = managerName;
        this.phone = phone;
        this.facebook = facebook;
        this.email = email;
        this.wins = wins;
        this.loses = loses;
        this.draws = draws;
    }
}
