import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { PopUpReuestConfirmationComponent } from './pop-up-reuest-confirmation.component';

describe('PopUpReuestConfirmationComponent', () => {
  let component: PopUpReuestConfirmationComponent;
  let fixture: ComponentFixture<PopUpReuestConfirmationComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ PopUpReuestConfirmationComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PopUpReuestConfirmationComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
