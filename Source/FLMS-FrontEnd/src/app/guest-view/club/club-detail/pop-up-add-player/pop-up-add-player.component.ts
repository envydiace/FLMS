import { Component, Inject, OnInit } from '@angular/core';
import { MatDialogRef, MAT_DIALOG_DATA } from '@angular/material/dialog';
import { FormBuilder, FormGroup, FormControl, Validators } from '@angular/forms';

@Component({
  selector: 'app-pop-up-add-player',
  templateUrl: './pop-up-add-player.component.html',
  styleUrls: ['./pop-up-add-player.component.scss']
})
export class PopUpAddPlayerComponent implements OnInit {
  addPlayerFormGroup: FormGroup;

  constructor(
    private formBuilder: FormBuilder,
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

  onSubmit() {
    
  }
}
