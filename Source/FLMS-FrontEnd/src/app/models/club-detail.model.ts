export class ClubDetail {
    private id: number;
    private clubName: string;
    private managerName: string;
    private phone: number;
    private facebook: string;
    private email: string;
    private wins: number;
    private loses: number;
    private draws: number;

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
