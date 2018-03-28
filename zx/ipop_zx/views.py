from django.shortcuts import render,HttpResponse

# Create your views here.




def test(request):
    return HttpResponse('test')

def index(request):
    data = {'headline':"IPOP"}
    return render(request, 'ipop_zx/ipop.html',data)