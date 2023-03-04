import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { FlmsRoutingModule } from './flms-routing.module';
import { CreateClubComponent } from './club/create-club/create-club.component';
import { MatInputModule } from '@angular/material/input';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatGridListModule } from '@angular/material/grid-list';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatCardModule } from '@angular/material/card';
import { MatButtonModule } from '@angular/material/button';
import { ViewProfileComponent } from './profile/view-profile/view-profile.component';
import {MatIconModule} from '@angular/material/icon';


@NgModule({
  declarations: [CreateClubComponent, ViewProfileComponent],
  imports: [
    CommonModule,
    FlmsRoutingModule,
    MatInputModule,
    FlmsRoutingModule,
    MatGridListModule,
    MatFormFieldModule,
    MatButtonModule,
    MatIconModule,
    MatCardModule,
    FormsModule,
    ReactiveFormsModule
  ]
})
export class FlmsModule { }
