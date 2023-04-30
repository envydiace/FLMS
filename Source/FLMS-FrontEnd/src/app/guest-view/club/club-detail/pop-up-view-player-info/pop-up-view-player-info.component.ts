import { Component, Inject, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { ClubListPlayerClub } from 'src/app/models/club-list-player-club.model';
import { ClubListPlayer } from 'src/app/models/club-list-player.model';
import { ClubService } from '../../club.service';
import { CommonService } from 'src/app/common/common/common.service';
import { ClubPlayerInfoResponse } from 'src/app/models/player-info-response.model';
import { map } from 'rxjs/operators';
import { MAT_DIALOG_DATA } from '@angular/material/dialog';

@Component({
  selector: 'app-pop-up-view-player-info',
  templateUrl: './pop-up-view-player-info.component.html',
  styleUrls: ['./pop-up-view-player-info.component.scss']
})
export class PopUpViewPlayerInfoComponent implements OnInit {
  playerInfo: ClubListPlayer = null;
  playerClub: ClubListPlayerClub[];
  form: FormGroup;
  loading = false;
  submitted = false;
  playerId: number;
  defaultLogo: string = './../../../../assets/image/clubDefaultLogo.png';
  defaultAvatar: string = './../../../../assets/image/Default_pfp.svg.png';

  playerNum: number;

  constructor(
   private formBuilder: FormBuilder,
    private route: ActivatedRoute,
    private router: Router,
    private clubService: ClubService,
    public commonService: CommonService,
    @Inject(MAT_DIALOG_DATA)
    public data: {
      playerId: number;
    },

  ) {
  
   }

  ngOnInit(): void {
    this.initDataSource();

    this.form = this.formBuilder.group({
      playerId: this.playerId,
      name: [null, Validators.required],
      nickName: [null,],
      number: [null, Validators.required],
      dob: [null, Validators.required],
      height: [null, Validators.required],
      weight: [null, Validators.required],
      phoneNumber: [null, Validators.required],
      address: [null, Validators.required],
      email: [null, Validators.required],
      socialCont: [null, Validators.required],
      avatar: [null,]
    })

  }


  get f() { return this.form.controls; }

  initDataSource() {
    this.getPlayerInfo();
  }
  getPlayerInfo() {
    this.clubService.getPlayerInfo(this.data.playerId).pipe(
      map((res: ClubPlayerInfoResponse) =>
        //  {
        this.playerInfo = res.playerInfo
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
    this.form.controls['number'].patchValue(this.playerInfo.playerClubs);
    this.form.controls['dob'].patchValue(res.dob);
    this.form.controls['height'].patchValue(res.height);
    this.form.controls['weight'].patchValue(res.weight);
    this.form.controls['phoneNumber'].patchValue(res.phoneNumber);
    this.form.controls['address'].patchValue(res.address);
    this.form.controls['email'].patchValue(res.email);
    this.form.controls['socialCont'].patchValue(res.socialCont);
    this.form.controls['avatar'].patchValue(res.avatar);

    this.form.controls['name'].disable();
    this.form.controls['nickName'].disable();
    this.form.controls['number'].disable();
    this.form.controls['dob'].disable();
    this.form.controls['height'].disable();
    this.form.controls['weight'].disable();
    this.form.controls['phoneNumber'].disable();
    this.form.controls['address'].disable();
    this.form.controls['email'].disable();
    this.form.controls['socialCont'].disable();

  }

}
