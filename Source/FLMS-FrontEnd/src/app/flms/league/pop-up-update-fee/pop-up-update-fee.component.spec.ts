import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { PopUpUpdateFeeComponent } from './pop-up-update-fee.component';

describe('PopUpUpdateFeeComponent', () => {
  let component: PopUpUpdateFeeComponent;
  let fixture: ComponentFixture<PopUpUpdateFeeComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ PopUpUpdateFeeComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PopUpUpdateFeeComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
