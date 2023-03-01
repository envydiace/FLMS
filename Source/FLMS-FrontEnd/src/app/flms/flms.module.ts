import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { FlmsRoutingModule } from './flms-routing.module';
import { CreateClubComponent } from './club/create-club/create-club.component';
import {MatInputModule} from '@angular/material/input';


@NgModule({
  declarations: [CreateClubComponent],
  imports: [
    CommonModule,
    FlmsRoutingModule, 
    MatInputModule
  ]
})
export class FlmsModule { }
