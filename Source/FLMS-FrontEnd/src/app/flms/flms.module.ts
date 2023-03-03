import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { FlmsRoutingModule } from './flms-routing.module';
import { CreateClubComponent } from './club/create-club/create-club.component';
import { FlmsComponent } from './flms.component';
import { MatInputModule } from '@angular/material/input';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { MatGridListModule } from '@angular/material/grid-list';
import { MatFormFieldModule } from '@angular/material/form-field';
import { MatCardModule } from '@angular/material/card';
import { MatButtonModule } from '@angular/material/button';
import { VerticalMenuComponent } from './vertical-menu/vertical-menu.component';
import { MatIconModule } from '@angular/material/icon';
import { MatDividerModule } from '@angular/material/divider';
import {MatExpansionModule} from '@angular/material/expansion';


@NgModule({
  declarations: [
    CreateClubComponent,
    FlmsComponent,
    VerticalMenuComponent
  ],
  imports: [
    CommonModule,
    FlmsRoutingModule,
    MatInputModule,
    MatGridListModule,
    MatFormFieldModule,
    MatIconModule,
    MatExpansionModule,
    MatDividerModule,
    MatButtonModule,
    MatCardModule,
    FormsModule,
    ReactiveFormsModule
  ]
})
export class FlmsModule { }
