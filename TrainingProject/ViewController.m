//
//  ViewController.m
//  TrainingProject
//
//  Created by Mayank on 23/06/17.
//  Copyright © 2017 Mayank. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILongPressGestureRecognizer *longPress;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *dragGesture;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UIImageView *myImage;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapImage;
@property(nonatomic)NSUInteger numberOfTouches;
@property(nonatomic,strong)NSSet *touches;
@property(nonatomic,strong)UIEvent *event;
@property(nonatomic)CGPoint originalCenter;
@property (weak, nonatomic) IBOutlet UIView *myView;
@property (strong, nonatomic) IBOutlet UIPinchGestureRecognizer *pichMe;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mySegment;
@property (weak, nonatomic) IBOutlet UITextField *myText;
@property (weak, nonatomic) IBOutlet UISlider *mySlider;
@property (weak, nonatomic) IBOutlet UIProgressView *sliderProgress;

@property (weak, nonatomic) IBOutlet UILabel *dragLabel;
@end

@implementation ViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.dragLabel.userInteractionEnabled=YES;
    self.dragGesture=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(dragIt:)];
    [self.dragLabel addGestureRecognizer:self.dragGesture];
    
    self.longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    [self.button addGestureRecognizer:self.longPress];
    
    self.myImage.image=[UIImage imageNamed:@"myimage"];
    self.myImage.userInteractionEnabled=YES;
    self.myImage.multipleTouchEnabled=YES;
    self.tapImage=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImage:)];
    [self.myImage addGestureRecognizer:self.tapImage];
    
    self.myView.backgroundColor=[UIColor blueColor];
    self.myView.userInteractionEnabled=YES;
    self.pichMe=[[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchMe:)];
    [self.myView addGestureRecognizer:self.pichMe];
    self.myText.delegate=self;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(![textField.text isEqual:@""])
    {
        UIAlertController* alert=[UIAlertController alertControllerWithTitle:@"Message"
                                                                     message:textField.text
                                                              preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* action=[UIAlertAction actionWithTitle:@"Return"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction* actionn){}];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];

    }
    return YES;
    
}
- (IBAction)changeLabel:(UISlider *)sender
{
    if(sender==self.mySlider)
    {
        self.dragLabel.text=[NSString stringWithFormat:@"value of slider %d",(int)self.mySlider.value];
        self.sliderProgress.progress=(self.mySlider.value)/(self.mySlider.maximumValue);
    }

}

- (IBAction)toggleSwitch:(UISwitch *)sender
{
    if([sender isOn])
    {
        UIAlertController* alert=[UIAlertController alertControllerWithTitle:@"Message"
                                                                     message:@"The switch is on"
                                                              preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* action=[UIAlertAction actionWithTitle:@"Return"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction* actionn){}];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];

    }
    else
    {
        UIAlertController* alert=[UIAlertController alertControllerWithTitle:@"Message"
                                                                     message:@"The switch is off"
                                                              preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* action=[UIAlertAction actionWithTitle:@"Return"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction* actionn){}];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];

    }
    
}
- (IBAction)tellSegment:(UISegmentedControl *)sender
{
    NSString *title = [self.mySegment titleForSegmentAtIndex:self.mySegment.selectedSegmentIndex];
    UIAlertController* alert=[UIAlertController alertControllerWithTitle:@"Message"
                                                                 message:title
                                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* action=[UIAlertAction actionWithTitle:@"Return"
                                                   style:UIAlertActionStyleDefault
                                                 handler:^(UIAlertAction* actionn){}];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];

}

-(void)pinchMe:(UIPinchGestureRecognizer *)gesture
{
    if(gesture.state==UIGestureRecognizerStateChanged)
    {
        CGRect frame = [self.myView frame];
        frame.size.width = frame.size.width *  gesture.scale;
        frame.size.height=frame.size.height *   gesture.scale;
        [self.myView setFrame:frame];
    }
   
}

-(void)tapImage:(UITapGestureRecognizer *)gesture
{
    if(gesture.state==UIGestureRecognizerStateEnded)
    {
        [self touchesBegan:self.touches withEvent:self.event];
        UIAlertController* alert=[UIAlertController alertControllerWithTitle:@"Message"
                                                                     message:[NSString stringWithFormat:@"Image tapped with %lu fingers",self.numberOfTouches]
                                                              preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* action=[UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction* actionn){}];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([touches count] > 0) {
        self.numberOfTouches=[touches count];
    }
}

-(void)longPress:(UILongPressGestureRecognizer *)gesture
{
    if(gesture.state==UIGestureRecognizerStateEnded)
    {
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Caution!"
                                                                       message:@"Button pressed for too long"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
       UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {}];
        
        [alert addAction:defaultAction];
        [self presentViewController:alert animated:YES completion:nil];
    }
}


-(void)dragIt:(UIPanGestureRecognizer *)gesture
{
  self.dragLabel= (UILabel *)gesture.view;
    CGPoint translation = [gesture translationInView:self.view];
   
    switch (gesture.state)
    {
        case UIGestureRecognizerStateBegan:{
            self.originalCenter=self.dragLabel.center;
        }
            
            break;
        case UIGestureRecognizerStateChanged:{
            self.dragLabel.center = CGPointMake(self.dragLabel.center.x + translation.x,
                                       self.dragLabel.center.y + translation.y);
        }
            
        case UIGestureRecognizerStateEnded:{
            [UIView animateWithDuration: 8
                             animations:^{
                                 self.dragLabel.center = self.originalCenter;
                             }
                             completion:^(BOOL finished){
                                NSLog(@"Returned");
                             }];        }
            
        default:
            break;
    }
    //self.dragLabel.center = self.originalCenter;
    [gesture setTranslation:CGPointZero inView:self.view];
    
}


@end
