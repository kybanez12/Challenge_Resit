using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using SVSApp.Models;

namespace SVSApp.Controllers
{
    public class TreatmentsMVCController : Controller
    {
        private kychallengeEntities db = new kychallengeEntities();

        // GET: TreatmentsMVC
        public ActionResult Index()
        {
            var treatments = db.Treatments.Include(t => t.Pet).Include(t => t.Procedure);
            return View(treatments.ToList());
        }

        // GET: TreatmentsMVC/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Treatment treatment = db.Treatments.Find(id);
            if (treatment == null)
            {
                return HttpNotFound();
            }
            return View(treatment);
        }

        // GET: TreatmentsMVC/Create
        public ActionResult Create()
        {
            ViewBag.PetID = new SelectList(db.Pets, "PetID", "Name");
            ViewBag.ProcedureID = new SelectList(db.Procedures, "ProcedureID", "Description");
            return View();
        }

        

        // POST: TreatmentsMVC/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "ProcedureID,PetID,Date,Notes,Price")] Treatment treatment)
        {
            if (ModelState.IsValid)
            {
                db.Treatments.Add(treatment);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.PetID = new SelectList(db.Pets, "PetID", "Name", treatment.PetID);
            ViewBag.ProcedureID = new SelectList(db.Procedures, "ProcedureID", "Description", treatment.ProcedureID);
            return View(treatment);
        }

        // GET: TreatmentsMVC/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Treatment treatment = db.Treatments.Find(id);
            if (treatment == null)
            {
                return HttpNotFound();
            }
            ViewBag.PetID = new SelectList(db.Pets, "PetID", "Name", treatment.PetID);
            ViewBag.ProcedureID = new SelectList(db.Procedures, "ProcedureID", "Description", treatment.ProcedureID);
            return View(treatment);
        }

        // POST: TreatmentsMVC/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "ProcedureID,PetID,Date,Notes,Price")] Treatment treatment)
        {
            if (ModelState.IsValid)
            {
                db.Entry(treatment).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.PetID = new SelectList(db.Pets, "PetID", "Name", treatment.PetID);
            ViewBag.ProcedureID = new SelectList(db.Procedures, "ProcedureID", "Description", treatment.ProcedureID);
            return View(treatment);
        }

        // GET: TreatmentsMVC/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Treatment treatment = db.Treatments.Find(id);
            if (treatment == null)
            {
                return HttpNotFound();
            }
            return View(treatment);
        }

        // POST: TreatmentsMVC/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            Treatment treatment = db.Treatments.Find(id);
            db.Treatments.Remove(treatment);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
