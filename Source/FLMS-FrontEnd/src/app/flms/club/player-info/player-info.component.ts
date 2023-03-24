import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { map } from 'rxjs/operators';
import { CommonService } from 'src/app/common/common/common.service';
import { ClubListPlayerClub } from 'src/app/models/club-list-player-club.model';
import { ClubListPlayer } from 'src/app/models/club-list-player.model';
import { ClubPlayerInfoResponse } from 'src/app/models/player-info-response.model';
import { ClubService } from '../club.service';

@Component({
  selector: 'app-player-info',
  templateUrl: './player-info.component.html',
  styleUrls: ['./player-info.component.scss']
})
export class PlayerInfoComponent implements OnInit {
  playerInfo: ClubListPlayer = null;
  playerClub: ClubListPlayerClub[];
  form: FormGroup;
  loading = false;
  submitted = false;
  playerId: number;

  playerNum: number;


  constructor(
    private formBuilder: FormBuilder,
    private route: ActivatedRoute,
    private router: Router,
    public commonService: CommonService,
    private clubService: ClubService,

  ) {
    this.route.queryParams.subscribe(params => {
      this.playerId = params['playerId'];
    });
  }

  ngOnInit(): void {
    this.clubService.getPlayerInfo(this.playerId).pipe(
      map((res: ClubPlayerInfoResponse) =>
      //  {
        this.playerInfo = res.playerInfo,
      //   this.playerClub = res.playerInfo.playerClubs
      // }
       )
    ).subscribe(response => {
      if (response != null) this.bindValueIntoForm(response);
    }
    );
  }

  initDataSource() {
    this.clubService.getPlayerInfo(this.playerId).pipe(
      map((res: ClubPlayerInfoResponse) =>
        //  {
        this.playerInfo = res.playerInfo,
        //   this.playerClub = res.playerInfo.playerClubs
        // }
      )
    ).subscribe(response => {
      if (response != null) this.bindValueIntoForm(response);
    }
    );
  }

  bindValueIntoForm(res: ClubListPlayer) {
    this.playerClub = res.playerClubs

    this.form.controls['name'].patchValue(res.name);
    this.form.controls['nickName'].patchValue(res.nickName);

    this.form.controls['number'].patchValue(this.playerClub);
    this.form.controls['dob'].patchValue(res.dob);
    this.form.controls['height'].patchValue(res.height);
    this.form.controls['weight'].patchValue(res.weight);

    this.form.controls['phoneNumber'].patchValue(res.phoneNumber);
    this.form.controls['address'].patchValue(res.address);
    this.form.controls['email'].patchValue(res.email);
    this.form.controls['socialCont'].patchValue(res.socialCont);

    this.form.controls['nickName'].disable();
    this.form.controls['socialCont'].disable();
  }

}
