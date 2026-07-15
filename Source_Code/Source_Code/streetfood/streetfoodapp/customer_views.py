from django.db.models import Q
from django.shortcuts import render, redirect
from streetfoodapp.models import Contact, Customer, Foodcourt, Merchant, Addcart, Feedback, Admin, Address, Order_Items, Order
from streetfoodapp.forms import ContactForms, CustomerForms, FoodcourtForms, AddcartForms, FeedbackForms, AdminForm, \
    AddressForm, OrderForm, OrdersForm


# Create your views here.
def index(request):
    food = Foodcourt.objects.all()
    return render(request, "index.html", {"foods": food})


def about(request):
    return render(request, "about.html", {})


def menu(request):
    food = Foodcourt.objects.all()
    menu = Foodcourt.objects.all()
    return render(request, "menu.html", {"foods": food, "menus": menu})


def services(request):
    return render(request, "services.html", {})


def blog(request):
    return render(request, "blog.html", {})


def contact(request):
    return render(request, "contact.html", {})


def contactpage(request):
    if request.method == "POST":
        contact = ContactForms(request.POST)
        print('hi')
        if contact.is_valid():
            print(contact.errors)
            contact.save()
            return render(request, "contact.html", {"msg": "Success"})
    return render(request, "contact.html", {"msg":"Invalid Email"})


def customer(request):
    return render(request, "customer.html", {})


def customer_login(request):
    if request.method == "POST":
        email = request.POST["email"]
        password = request.POST["password"]
        print(email, "", password)
        customer = Customer.objects.filter(email=email, password=password)
        if customer.exists():
            request.session['email'] = email
            return render(request, "customerprofile.html", {"msg": email})
        else:
            return render(request, "customer.html", {"msg": "Invalid Email or Password"})
    return render(request, "customer.html", {"msg": "Invalid Email or Password"})


def customer_regpage(request):
    return render(request, "customer_regpage.html", {})


def reg(request):
    if request.method == "POST":
        email = request.POST["email"]
        print("hai")
        if Customer.objects.filter(email=email).exists():
            print("email already taken")
            return render(request, "customer_regpage.html", {"msg": "email already taken"})
        else:
            form = CustomerForms(request.POST)
            print("error:", form.errors)
            if form.is_valid():
                try:
                    form.save()
                    return render(request, "customer.html", {"msg": "REGISTER SUCCESS"})
                except Exception as e:
                    print(e)
                    print("hii")
            return render(request, "customer_regpage.html", {"msg": "REGISTER  IS FAIL"})


def customer_logout(request):
    request.session["email"] = ""
    del request.session["email"]
    return render(request, "customer.html", {})


def customer_details_display(request):
    email = request.session['email']
    customers = Customer.objects.get(email=email)
    print('ram')
    return render(request, "customer_details.html", {"customer": customers})


def is_customer(request):
    if request.session.__contains__("email"):
        return True
    else:
        return False


def customer_change_password(request):
    if is_customer(request):
        if request.method == "POST":
            email = request.session["email"]
            password = request.POST["password"]
            newpassword = request.POST["newpassword"]
            try:
                user = Customer.objects.get(email=email, password=password)
                user.password = newpassword

                user.save()
                msg = 'Successfully Password Update'
                return render(request, "customer.html", {"msg": msg})
            except:
                msg = 'invalid data'
                return render(request, "customer change password.html", {"msg": msg})
        return render(request, "customer change password.html", {})
    else:
        return render(request, "customerprofile.html", {})


def customerprofile(request):
    return render(request, "customerprofile.html", {})


def customer_delete(request, email):
    user = Customer.objects.get(email=email)
    user.delete()
    return redirect("/customer_regpage")


def customer_edit(request, email):
    customer = Customer.objects.get(email=email)
    return render(request, "customer_edit.html", {"customer": customer})


def customer_update(request):
    if request.method == "POST":
        print("error:")
        email = request.POST["email"]
        print("hello")
        customer = Customer.objects.get(email=email)
        customer = CustomerForms(request.POST, instance=customer)
        print("error:", customer.errors)
        if customer.is_valid():
            print("error:", customer.errors)
            customer.save()
        return redirect("/customer_details_display")
    return redirect("/customer_details_display")


def customer_view_food(request):
    hotel = Merchant.objects.all()
    return render(request, "customer_view_food.html", {"hotels": hotel})


def view_menu(request, id):
    merchant = Merchant.objects.get(id=id)
    food = Foodcourt.objects.filter(merchant_id=merchant.id)
    print("hii")
    return render(request, "view_menu.html", {"foods": food, "hotel": merchant.hotel, "id": merchant.id})


def customer_order_food(request, id):
    email = request.session['email']
    customer = Customer.objects.get(email=email)
    food = Foodcourt.objects.get(id=id)
    if request.method == "POST":
        if Addcart.objects.filter(food=food, customer=customer).exists():
            print("email already taken")
            return render(request, "add_to_cart.html",
                          {"msg": "All ready this food is in Cart", "customer": customer.id, "food": food.id,
                           "cost": food.cost, "dis": food.discount, "merchant": food.merchant.hotel,
                           "foodname": food.foodname, "type": food.type, "image": food.image.url})
        elif Addcart.objects.filter(~Q(food=food.merchant.id)):
            return render(request, "add_to_cart.html",{"msg": "Maximum One Hotel Selected in to Cart", "customer": customer.id, "food": food.id,
             "cost": food.cost, "dis": food.discount, "merchant": food.merchant.hotel,
             "foodname": food.foodname, "type": food.type, "image": food.image.url})
        else:
            book = AddcartForms(request.POST)
            print("errrors", book.errors)
            print('hii')
            if book.is_valid():
                print("error:", book.errors)
                book.save()
            return render(request, "add_to_cart.html",
                          {"msg": "Success", "customer": customer.id, "food": food.id, "cost": food.cost,
                           "dis": food.discount, "merchant": food.merchant.hotel, "foodname": food.foodname,
                           "type": food.type, "image": food.image.url})
        return render(request, "add_to_cart.html",
                      {"customer": customer.id, "food": food.id, "cost": food.cost, "dis": food.discount,
                       "merchant": food.merchant.hotel, "foodname": food.foodname, "type": food.type,
                       "image": food.image.url})
    return render(request, "add_to_cart.html",
                  {"customer": customer.id, "food": food.id, "cost": food.cost, "dis": food.discount,
                   "merchant": food.merchant.hotel, "foodname": food.foodname, "type": food.type,
                   "image": food.image.url})


def customer_view_order(request):
    email = request.session['email']
    customer = Customer.objects.get(email=email)
    print("hi11")
    details = Addcart.objects.filter(customer_id=customer.id)
    # totalq = 0
    # totalcost = 0
    # totaldiscount = 0
    # totalcosts = 0
    # for item in details:
    #     totalq = totalq+int(item.cart)
    #     totalcost = totalcost+int(item.cost)
    #     totaldiscount = totaldiscount+int(item.discount)
    #     totalcosts = totalcosts+int(item.finalcost)
    tq = 0
    tc = 0
    td = 0
    fc = 0
    for x in details:
        tq = tq + int(x.cart)
        tc = tc + int(x.cost) * int(x.cart)
        td = td + int(x.discount) * int(x.cart)
    fc = fc + tc - td

    adds = Address.objects.filter(email=email)
    print("ryy")
    return render(request, "customer_view_order.html",
                  {"orders": details, "adds": adds, "totalq": tq, "totalcost": tc,
                   "totaldiscount": td, "totalcosts": fc})


def feedback(request, id):
    email = request.session['email']
    customer = Customer.objects.get(email=email)
    merchant = Merchant.objects.get(id=id)
    if request.method == "POST":
        feedback = FeedbackForms(request.POST)
        if feedback.is_valid():
            feedback.save()
            return render(request, "feedback.html",
                          {"msg": "success", "customer": customer.id, "merchant": merchant.id})
    return render(request, "feedback.html", {"customer": customer.id, "merchant": merchant.id})


def customer_view_feedback(request, id):
    merchant = Merchant.objects.get(id=id)
    feedback = Feedback.objects.filter(merchant_id=merchant.id)
    return render(request, "customer_view_feedback.html", {"feedbacks": feedback, "merchant": merchant.hotel})


def unknownadmin(request):
    return render(request, "administration.html", {})


def administration(request):
    return render(request, "administration.html", {})


def admin_login(request):
    if request.method == "POST":
        email = request.POST['email']
        password = request.POST['password']
        print(email, " ", password)
        admin = Admin.objects.filter(email=email, password=password)
        if admin.exists():
            print("hello")
            request.session["email"] = email
            return render(request, "admin_profile.html", {"msg": email})
        else:
            return render(request, "admin_login.html", {"msg": "Invalid Email or Password"})
    return render(request, "admin_login.html", {"msg": ""})


def is_admin_login(request):
    if request.session.__contains__("email"):
        return True
    else:
        return False


def admin_logout(request):
    request.session["email"] = ""
    del request.session["email"]
    return render(request, "index.html", {})


def admin_change(request):
    if is_admin_login(request):
        if request.method == "POST":
            email = request.session["email"]
            password = request.POST["password"]
            newpassword = request.POST["newpassword"]
            try:
                admin = Admin.objects.get(email=email, password=password)
                admin.password = newpassword
                admin.save()
                msg = "Password Updated Successfully"
                return render(request, "admin_login.html", {"msg": msg})
            except:
                msg = "inavlid data"
                return render(request, "admin_change.html", {"msg": msg})
        return render(request, "admin_change.html", {})
    else:
        return render(request, "admin_change.html", {})


def admin_view_customers(request):
    customers = Customer.objects.all()
    return render(request, "admin_view_customers.html", {"customers": customers})


def admin_view_merchants(request):
    merchants = Merchant.objects.all()
    return render(request, "admin_view_merchants.html", {"merchants": merchants})


def admin_view_feedback(request):
    feedbacks = Contact.objects.all()
    return render(request, "admin_view_feedback.html", {"feedbacks": feedbacks})


def order_cancel(request, food_id):
    cancel = Addcart.objects.get(id=food_id)
    cancel.stutuss = 4
    cancel.save()
    return redirect("/customer_view_order")


def admin_view_orders(request):
    orders = Order_Items.objects.all()
    return render(request, "admin_view_orders.html", {"orders": orders})


# def customer_order_edit(request):
#     details = Addcart.objects.filter(customer_id=customer.id)
#     return render(request, "customer_order_edit.html", {"details": details})
#
#
# def customer_order_update(request):
#     if request.method == "POST":
#         print("error:")
#         email = request.POST["email"]
#         print("hello")
#         details = Addcart.objects.get(email=email)
#         details = AddcartForms(request.POST, instance=details)
#         print("error:", details.errors)
#         if details.is_valid():
#             print("error:", details.errors)
#             details.save()
#         return redirect("/customer_view_order")
#     return redirect("/customer_view_order")

def customer_order_edit(request, id):
    food = Addcart.objects.get(id=id)
    return render(request, "customer_order_edit.html", {"food": food})


# def customer_order_update(request):
#     global id
#     email = request.session['email']
#     customer = Customer.objects.get(email=email)
#     food=Foodcourt.objects.get(id=id)
#     if request.method == "POST":
#         id = request.POST["id"]
#         food = Addcart.objects.get(id=id)
#         food = Addcart.objects.filter(customer_id=customer.id)
#         food = AddcartForms(request.POST, request.FILES, instance=food)
#         print('hi')
#         print(food.errors)
#         if food.is_valid():
#             print(food.errors)
#             food.save()
#             return render(request, "customer_view_order.html", {"food": food})
#     return render(request, "customer_view_order.html", {"id": id})

def customer_order_update(request):
    global id
    email = request.session['email']
    customer = Customer.objects.get(email=email)
    if request.method == "POST":
        id = request.POST["id"]
        food = Addcart.objects.get(id=id)
        food = AddcartForms(request.POST, request.FILES, instance=food)
        print('hi')
        print(food.errors)
        if food.is_valid():
            print(food.errors)
            food.save()
            foods = Addcart.objects.filter(customer_id=customer.id)
            return render(request, "customer_view_order.html", {"foods": foods})
    return render(request, "customer_view_order.html", {"id": id})


def order_delete(request, id):
    food = Addcart.objects.get(id=id)
    food.delete()
    return render(request, "customer_view_order.html", {})


def add_address(request):
    email = request.session['email']
    customer = Customer.objects.get(email=email)
    if request.method == "POST":
        address = AddressForm(request.POST)
        print('hi')
        if address.is_valid():
            print(address.errors)
            address.save()
            return render(request, "add_address.html", {"msg": "Success", "customer": customer.email})
    return render(request, "add_address.html", {"customer": customer.email})


def customer_view_address(request):
    email = request.session['email']
    address = Address.objects.filter(email=email)
    return render(request, "customer_view_address.html", {"address": address})


def customer_address_edit(request, id):
    address = Address.objects.get(id=id)
    return render(request, "customer_address_edit.html", {"address": address})


def customer_address_update(request):
    if request.method == "POST":
        addressid = request.POST["id"]
        address = Address.objects.get(id=addressid)
        address = AddressForm(request.POST, instance=address)
        print("errors", address.errors)
        if address.is_valid():
            address.save()
            print("hell2.0")
            return redirect("/customer_view_address")
    return redirect("/customer_view_address")


def address_delete(request, id):
    address = Address.objects.get(id=id)
    address.delete()
    return redirect("/add_address")


def checkout(request):
    email = request.session['email']
    adds = Address.objects.filter(email=email)
    cart = Addcart.objects.all()
    tq = 0
    tc = 0
    td = 0
    fc = 0
    email = 0
    vmail = 0
    for x in cart:
        email = x.customer.email
        vmail = x.food.merchant.email
        tq = tq + int(x.cart)
        tc = tc + int(x.cost) * int(x.cart)
        td = td + int(x.discount) * int(x.cart)
    fc = fc + tc - td
    if request.method == "POST":
        print("hello")
        form = OrderForm(request.POST)
        print("errors", form.errors)
        print('hii')
        if form.is_valid():
            print("error:", form.errors)
            x = form.save()
            print("x = ", x.id)
            cart_1 = Addcart.objects.all()
            for item in cart_1:
                Order_Items.objects.create(order=x, food=item.food, cost=item.cost, quantity=item.cart,
                                           discount=item.discount, total=item.finalcost, foodname=item.food.foodname,
                                           email=item.customer.email, vmail=item.food.merchant.email)
            cart_1.delete()
            return render(request, "checkout.html",
                          {"msg": "Your Order Is Success", "email": email, "vmail": vmail, "td": td, "tc": tc,
                           "tq": tq, "fc": fc, "adds": adds})
    return render(request, "checkout.html",
                  {"email": email, "vmail": vmail, "td": td, "tc": tc, "tq": tq, "fc": fc, "adds": adds})


def customer_view_orders(request):
    email = request.session["email"]
    orders = Order.objects.filter(email=email)
    return render(request, "customer_view_orders.html", {"orders": orders})

def customer_view_orders_items(request,id):
    orders = Order_Items.objects.filter(order_id=id)
    return render(request, "customer_view_orders_items.html", {"orders": orders})

def cancel_checkout(request, id):
    orders = Order.objects.get(id=id)
    if request.method == "POST":
        form = OrdersForm(request.POST, instance=orders)
        if form.is_valid():
            orders.status = "Cancelled"
            form.save()
            return redirect("/customer_view_orders")
    return render(request, "cancel_checkout.html", {"orders":orders})