import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { PopUpUploadRulesComponent } from './pop-up-upload-rules.component';

describe('PopUpUploadRulesComponent', () => {
  let component: PopUpUploadRulesComponent;
  let fixture: ComponentFixture<PopUpUploadRulesComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ PopUpUploadRulesComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PopUpUploadRulesComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
