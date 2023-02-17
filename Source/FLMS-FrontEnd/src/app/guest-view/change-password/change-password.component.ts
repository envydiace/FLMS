import { Component, OnInit } from '@angular/core';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { first } from 'rxjs/operators';
import {MatFormFieldModule} from '@angular/material/form-field';
import { MatInputModule } from '@angular/material/input';
export interface Tile {
  color: string;
  cols: number;
  rows: number;
  text: string;
}

@Component({
  selector: 'app-change-password',
  templateUrl: './change-password.component.html',
  styleUrls: ['./change-password.component.scss']
})
export class ChangePasswordComponent implements OnInit {

  form: FormGroup;
  loading = false;
  submitted = false;
  constructor(   
    private formBuilder: FormBuilder,
    private route: ActivatedRoute,
    private router: Router) { 
  }

  ngOnInit(): void {
    this.form = this.formBuilder.group({
      oldpassword: ['', Validators.required],
      password: ['', Validators.required],
      cfpassword: ['', Validators.required]
    });
  }
  get f() { return this.form.controls; }
  onSubmit() {
    this.submitted = true;

    // stop here if form is invalid
    if (this.form.invalid) {
        return;
    }
  }
  tiles: Tile[] = [
    {text: 'One', cols: 1, rows: 1, color: 'lightblue'},
    {text: 'Two', cols: 3, rows: 1, color: 'lightgreen'},
  ];
  hide = true;
}
