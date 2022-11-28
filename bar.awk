#!/usr/bin/awk -f
#------------------------------------------------------------------------------#
#                            Programmed By Liz                                 #
#------------------------------------------------------------------------------#
# 2022-11-23
# bar graph from data file
#
# loads data into array
# finds max column widths
#
# data, decimal or time, text optional
# config: min,max,bar,text       first line
# data: min,max,text             following lines
#                                blank & comment lines '#' allowed

# ==============================================================================
BEGIN {
   FS=","
   cnt=0
   siz=0
}
# ==============================================================================
{
   if(substr($0,1,1)!="#" && $0!="")   # ignore comment & blank
   {
      if(cnt==0)
      {
         min=$1                        # config
         max=$2
         bar=$3
         ttl=$4

         if(ttl=="")
            ttl="no title"
         system("title-80.sh -t line \""ttl"\"")

         n=int(log(max)/log(10))       # format
         switch(n)
         {
            case -1 :
               fmt="%5.4f"             # 0.1234
               break
            case 0 :
               fmt="%5.3f"             # 1.234
               break
            case 1 :
               fmt="%5.2f"             # 12.34
               break
            case 2 :
               fmt="%5.1f"             # 123.4
               break
            case 3 :
               fmt="%5.0f"             # 1234
               break
         }

         dx=max-min                    # equation
         m=bar/dx
         b=bar*(1-max/dx)
      }
      else
      {
         for(i=1;i<=3;i++)             # load data array
         {
            ary[cnt,i]=$i
         }
      }
      l=length(ary[cnt,3])             # max string length
      if(l>siz)
         siz=l
      cnt++
   }
}
# ==============================================================================
END {
   printf("%"siz+12"s "fmt"%"bar-8"s"fmt"\n","",min,"",max)
   for(q=1;q<cnt;q++)                  # display data
   {
      for(i=1;i<=2;i++)                # time
      {
         if(match(ary[q,i],":"))
         {
            split(ary[q,i],t,":")
            ary[q,i]=t[1]+t[2]/60+t[3]/60/60
            d[i]=sprintf("%2d:%02d",t[1],t[2]+int(t[3]/60+0.5))
         }
         else                          # decimal
            d[i]=sprintf(fmt,ary[q,i])
      }

      x[1]=ary[q,1];x[2]=ary[q,2]
      for(i=1;i<=2;i++)
      {
         y[i]=int(m*x[i]+b+0.5)
      }
      printf("%"siz"s %5s %5s >",ary[q,3],d[1],d[2])
      s=""
      if(x[2]>x[1])                    # valid data range
      {
         for(i=0;i<y[1];i++)
            s=s" "
         for(i=y[1];i<y[2];i++)
            s=s"|"                     # |░▒▓█
         for(i=y[2];i<bar;i++)
            s=s" "
      }
      else                             # invalid data range
         for(i=0;i<bar;i++)
            s=s" "
      printf("%s<\n",s)
   }
}
# ==============================================================================
# functions
# ------------------------------------------------------------------------------
# ==============================================================================
