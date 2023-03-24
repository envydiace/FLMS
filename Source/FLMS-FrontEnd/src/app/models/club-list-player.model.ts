import { ClubListPlayerClub } from './club-list-player-club.model';

export interface ClubListPlayer {
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
    playerClubs: ClubListPlayerClub[];
    goal:number;
    assistant:number;
    redCard:number;
    yellowCard:number;
    avatar: string;
}

export class ClubListPlayer implements ClubListPlayer {
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
        playerClubs: ClubListPlayerClub[],
        goal:number,
        assistant:number,
        redCard:number,
        yellowCard:number,
        avatar: string,
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
        this.goal = goal;
        this.assistant = assistant;
        this.redCard = redCard;
        this.yellowCard = yellowCard;
        this.avatar = avatar;
    }
}
