import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { map } from 'rxjs/operators';
import { CommonService } from 'src/app/common/common/common.service';
import { ClubListPlayerClub } from 'src/app/models/club-list-player-club.model';
import { ClubListPlayer } from 'src/app/models/club-list-player.model';
import { ClubPlayerInfoResponse } from 'src/app/models/player-info-response.model';
import { ClubService } from '../club.service';
import { DatePipe } from '@angular/common';
import { PopUpConfirmDeletePlayerComponent } from '../pop-up-confirm-delete-player/pop-up-confirm-delete-player.component';
import { MatDialog } from '@angular/material/dialog';

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
  clubId: number;

  playerNum: number;
  Dob: Date;

  constructor(
    private formBuilder: FormBuilder,
    private route: ActivatedRoute,
    private router: Router,
    public commonService: CommonService,
    private clubService: ClubService,
    public dialog: MatDialog,

  ) {
    this.route.queryParams.subscribe(params => {
      this.playerId = params['playerId'];
      this.clubId = params['clubId']
    });
  }

  ngOnInit(): void {
    this.initDataSource();

    this.form = this.formBuilder.group({
      playerId: this.playerId,
      name: ['', Validators.required],
      nickName: ['',],
      number: ['', Validators.required],
      dob: ['', Validators.required],
      height: ['', Validators.required],
      weight: ['', Validators.required],
      phoneNumber: ['', Validators.required],
      address: ['', Validators.required],
      email: ['', Validators.required],
      socialCont: ['',],

    })
  }
  get f() { return this.form.controls; }


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
    this.playerClub = res.playerClubs;
  

    this.form.controls['name'].patchValue(res.name);
    this.form.controls['nickName'].patchValue(res.nickName);

    this.form.controls['number'].patchValue(this.playerClub);
    this.form.controls['dob'].patchValue(res.dob );
    this.form.controls['height'].patchValue(res.height);
    this.form.controls['weight'].patchValue(res.weight);

    this.form.controls['phoneNumber'].patchValue(res.phoneNumber);
    this.form.controls['address'].patchValue(res.address);
    this.form.controls['email'].patchValue(res.email);
    this.form.controls['socialCont'].patchValue(res.socialCont);

    this.form.controls['nickName'].disable();
    this.form.controls['socialCont'].disable();
  }

    // public onSubmit() {
  //   this.submitted = true;
  //   // stop here if form is invalid
  //   if (this.form.invalid) {
  //     return;
  //   }
  //   this.loading = true;
  //   this.clubService.editPlayer(this.form.value)
  //     .pipe(first())
  //     .subscribe({
  //       next: () => {
  //         this.initDataSource();
  //         this.commonService.sendMessage('Update player s info success!', 'success');
  //       },
  //       error: error => {
  //         this.loading = false;
  //         this.commonService.sendMessage('Update fail!.', 'fail');
  //       }
  //     });

  // }

  openDeleteplayerConfirm(playerId: number, clubId:number): void {
    const dialogRef = this.dialog.open(PopUpConfirmDeletePlayerComponent, {
      width: '50%',
      data: { playerId: playerId , clubId: this.clubId}
    });
    dialogRef.afterClosed().subscribe(result => {
      console.log('The dialog was closed');
      

    });
  }


}
