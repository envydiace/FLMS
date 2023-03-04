import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { FlmsRoutingModule } from './flms-routing.module';
import { FlmsComponent } from './flms.component';
import { MatInputModule } from '@angular/material/input';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatGridListModule } from '@angular/material/grid-list';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatCardModule } from '@angular/material/card';
import { MatButtonModule } from '@angular/material/button';
import { MatIconModule } from '@angular/material/icon';
import { MatDividerModule } from '@angular/material/divider';
import { MatExpansionModule } from '@angular/material/expansion';
import { MatSidenavModule } from '@angular/material/sidenav';
import { BrowserModule } from '@angular/platform-browser';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';
import { CreateClubComponent } from './club/create-club/create-club.component';
import { RouterModule } from '@angular/router';

@NgModule({
  declarations: [
    FlmsComponent,
    CreateClubComponent
  ],
  imports: [
    CommonModule,
    RouterModule,
    MatInputModule,
    MatGridListModule,
    MatFormFieldModule,
    MatIconModule,
    MatSidenavModule,
    MatExpansionModule,
    MatDividerModule,
    MatButtonModule,
    MatCardModule,
    FormsModule,
    FlmsRoutingModule,
    ReactiveFormsModule
  ]
})
export class FlmsModule { }
