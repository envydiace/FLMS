import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';

import { FlmsRoutingModule } from './flms-routing.module';

import {MatGridListModule} from '@angular/material/grid-list';
import {MatFormFieldModule} from '@angular/material/form-field';
import {MatCardModule} from '@angular/material/card';


@NgModule({
  declarations: [

  ],
  imports: [
    CommonModule,
    FlmsRoutingModule,
    MatGridListModule, 
    MatFormFieldModule, 
    MatCardModule
  ]
})
export class FlmsModule { }
