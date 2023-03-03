import { playerInClub } from "./club-list-player-club.model";


export interface playerInClubList {
    playerId: number;
    name: string;
    nickName: string;
    dob: Date;
    height: string;
    weight: string;
    address: string;
    phoneNumber: string;
    email: string;
    socialCont: string;
    playerClubs: playerInClub[];
}

export class playerInClubList implements playerInClubList {
    constructor(
        playerId: number,
        name: string,
        nickName: string,
        dob: Date,
        height: string,
        weight: string,
        address: string,
        phoneNumber: string,
        email: string,
        socialCont: string,
        playerClubs: playerInClub[]
    ) {
        this.playerId = playerId;
        this.name = name;
        this.nickName = nickName;
        this.dob = dob;
        this.height = height;
        this.weight = weight;
        this.address = address;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.socialCont = socialCont;
        this.playerClubs = playerClubs;
    }
}
