from django.shortcuts import render,redirect
from streetfoodapp.models import Merchant,Foodcourt,Addcart,Customer,Feedback, Order, Order_Items
from streetfoodapp.forms import MerchantForms,FoodcourtForms,AddcartForms,CustomerForms,FeedbackForms, OrdersForm


def merchant(request):
    return render(request, "merchant.html", {})


def merchant_login(request):
    if request.method == "POST":
        email = request.POST["email"]
        password = request.POST["password"]
        print(email, "", password)
        merchant = Merchant.objects.filter(email=email, password=password)
        if merchant.exists():
            request.session['email'] = email
            return render(request, "merchantprofile.html", {"msg": email})
        else:
            return render(request, "merchant.html", {"msg": "Invalid Email or Password"})
    return render(request, "merchant.html", {"msg": "Invalid Email or Password"})


def merchant_regpage(request):
    return render(request,"merchant_regpage.html",{})


def merchant_register(request):
    if request.method == "POST":
        email = request.POST["email"]
        print("hai")
        if Merchant.objects.filter(email=email).exists():
            print("Email already taken")
            return render(request, "merchant_regpage.html", {"msg": "Email already taken"})
        else:
            form = MerchantForms(request.POST,request.FILES)
            print("error:", form.errors)
            if form.is_valid():
                try:
                    form.save()
                    return render(request, "merchant.html", {"msg": "REGISTER SUCCESS"})
                except Exception as e:
                    print(e)
                    print("hii")
            return render(request, "merchant_regpage.html", {"msg": "REGISTER  IS FAIL"})

def merchant_logout(request):
    request.session["email"] = ""
    del request.session["email"]
    return render(request, "merchant.html", {})


def merchant_details_display(request):
    email = request.session['email']
    merchant = Merchant.objects.get(email=email)
    print('ram')
    return render(request, "merchant_details.html", {"merchant": merchant})


def is_merchant(request):
    if request.session.__contains__("email"):
        return True
    else:
        return False


def merchant_change_password(request):
    if is_merchant(request):
        if request.method == "POST":
            email = request.session["email"]
            password = request.POST["password"]
            newpassword = request.POST["newpassword"]
            try:
                user = Merchant.objects.get(email=email, password=password)
                user.password = newpassword

                user.save()
                msg = 'Successfully Password Update '
                return render(request, "merchant.html", {"msg": msg})
            except:
                msg = 'invalid data'
                return render(request, "merchant change password.html", {"msg": msg})
        return render(request, "merchant change password.html", {})
    else:
        return render(request, "merchantprofile.html", {})


def merchant_edit(request, email):
    merchant = Merchant.objects.get(email=email)
    return render(request, "merchant_edit.html", {"merchant": merchant})


def merchant_update(request):
    if request.method == "POST":
        print("error:")
        email = request.POST["email"]
        print("hello")
        users = Merchant.objects.get(email=email)
        users = MerchantForms(request.POST, request.FILES, instance=users)
        print("error:", users.errors)
        if users.is_valid():
            print("error:", users.errors)
            users.save()
        return redirect("/merchant_details_display")
    return redirect("/merchant_details_display")

def merchant_delete(request, email):
    merchant = Merchant.objects.get(email=email)
    merchant.delete()
    return redirect("/merchant_regpage")


def add_food_court(request,id):
    email = request.session['email']
    merchant = Merchant.objects.get(email=email)
    food=Foodcourt.objects.filter(id=id)
    if request.method == "POST":
        food = FoodcourtForms(request.POST, request.FILES)
        print('hi')
        print("errors", food.errors)
        if food.is_valid():
            print(food.errors)
            food.save()
            return render(request, "add_food.html", {"msg": "success", "id": merchant.id,"hotel":merchant.hotel,"food":food})
    return render(request, "add_food.html", {"id": merchant.id,"food":food})


def merchant_view_food(request,id):
    merchant = Merchant.objects.get(id=id)
    food = Foodcourt.objects.filter(merchant_id=merchant.id)
    print("hii")
    return render(request, "merchant_view_food.html", {"foods": food,"hotel":merchant.hotel,"id":merchant.id})


def food_edit(request, id):
    food = Foodcourt.objects.get(id=id)
    return render(request, "food_edit.html", {"foods": food})


def food_update(request):
    global id
    email = request.session['email']
    merchant = Merchant.objects.get(email=email)
    if request.method == "POST":
        id = request.POST["id"]
        food = Foodcourt.objects.get(id=id)
        food = FoodcourtForms(request.POST, request.FILES, instance=food)
        print('hi')
        print(food.errors)
        if food.is_valid():
            print(food.errors)
            food.save()
            foods = Foodcourt.objects.filter(merchant_id=merchant.id)
            return render(request, "merchant_view_food.html", {"foods": foods,"hotel":merchant.hotel})
    return render(request, "merchant_view_food.html", {"id": id})

def food_delete(request, id):
    food = Foodcourt.objects.get(id=id)
    food.delete()
    return render(request,"add_food.html",{})



def food_order(request,id):
    orders=Addcart.objects.filter(food_id=id)
    print("hii1")
    return render(request, "merchant_view_bookings.html", {"orders": orders})


def approve_slot(request, food_id):
    approve=Addcart.objects.get(id=food_id)
    approve.stutuss = 1
    approve.save()
    return redirect("/merchant_details_display")


def reject_slot(request, food_id):
    reject=Addcart.objects.get(id=food_id)
    reject.stutuss = 2
    reject.save()
    return redirect("/merchant_details_display")


def delivered_slot(request, food_id):
    reject=Addcart.objects.get(id=food_id)
    reject.stutuss = 3
    reject.save()
    return redirect("/merchant_details_display")



def merchant_view_feedback(request):
    email=request.session['email']
    merchant=Merchant.objects.get(email=email)
    feedback=Feedback.objects.filter(merchant_id=merchant.id)
    return render(request,"merchant_view_feedback.html",{"feedbacks":feedback,"merchant":merchant.hotel})



def feedback_delete(request, id):
    feedback = Feedback.objects.get(id=id)
    feedback.delete()
    return redirect("/merchant_view_feedback")


def merchantprofile(request):
    return render(request,"merchantprofile.html",{})

def merchant_view_orders(request):
    email = request.session["email"]
    orders = Order.objects.filter(email=email)
    return render(request, "merchant_view_orders.html",{"orders":orders})


def accept_checkout(request, id):
    accept = Order.objects.get(id=id)
    accept.status = 'Accepted'
    accept.save()
    return redirect('/merchant_view_orders')

def reject_checkout(request, id):
    reject = Order.objects.get(id=id)
    reject.status = 'Rejected'
    reject.save()
    return redirect('/merchant_view_orders')

def delivery_checkout(request, id):
    delivery = Order.objects.get(id=id)
    delivery.status = 'Delivered'
    delivery.save()
    return redirect('/merchant_view_orders')

def merchant_view_order_items(request, id):
    orders = Order_Items.objects.filter(order_id=id)
    return render(request, "merchant_view_order_items.html", {"orders":orders})


