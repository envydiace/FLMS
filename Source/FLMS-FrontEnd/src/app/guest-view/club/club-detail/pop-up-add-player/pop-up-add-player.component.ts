import { Component, Inject, OnInit } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { FormBuilder, FormGroup, FormControl, Validators } from '@angular/forms';
import { ClubService } from '../../club.service';
import { first } from 'rxjs/operators';
import { Player } from 'src/app/models/player.model';

@Component({
  selector: 'app-pop-up-add-player',
  templateUrl: './pop-up-add-player.component.html',
  styleUrls: ['./pop-up-add-player.component.scss']
})
export class PopUpAddPlayerComponent implements OnInit {
  addPlayerFormGroup: FormGroup;
  loading = false;
  player: Player;

  constructor(
    private formBuilder: FormBuilder,
    private clubService: ClubService,
    public dialogRef: MatDialogRef<PopUpAddPlayerComponent>,
    @Inject(MAT_DIALOG_DATA)
    public data: {
      clubId: number;
      clubName: string;
    }
  ) { }

  ngOnInit(): void {
    this.createForm();
  }

  onNoClick(): void {
    this.dialogRef.close();
  }

  createForm() {
    this.addPlayerFormGroup = this.formBuilder.group({
      'playerName': [null, [Validators.required]],
      'number': [null, [Validators.required]],
      'playerHeight': [null, [Validators.required]],
      'address': [null, [Validators.required]],
      'email': [null, [Validators.required]],
      'nickname': [null, [Validators.required]],
      'dob': [null, [Validators.required]],
      'weight': [null, [Validators.required]],
      'phoneNumber': [null, [Validators.required]],
      'socialCont': [null, [Validators.required]],
    });
  }

  getControl(name: string) {
    return this.addPlayerFormGroup.get(name) as FormControl;
  }

  bindDataIntoPlayer() {
    this.player = {
      playerId: null,
      name: this.getControl('playerName').value,
      nickName: this.getControl('nickname').value,
      dob: this.getControl('dob').value,
      height: this.getControl('playerHeight').value,
      weight: this.getControl('weight').value,
      address: this.getControl('address').value,
      phoneNumber: this.getControl('phoneNumber').value,
      email: this.getControl('email').value,
      socialCont: this.getControl('socialCont').value,
      clubId: this.data.clubId,
      number: this.getControl('number').value
    }
  }

  onSubmit() {
    this.bindDataIntoPlayer();

    // stop here if form is invalid
    if (this.addPlayerFormGroup.invalid) {
      return;
    }

    this.loading = true;
    this.clubService.addPlayer(this.player)
      .pipe(first())
      .subscribe({
        next: () => {

        },
        error: error => {
          this.loading = false;
        }
      });
  }
}
